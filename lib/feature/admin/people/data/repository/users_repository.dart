import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_manager/core/data/user_firestore_service.dart';
import 'package:student_manager/core/firebase/secondary_firebase_auth.dart';
import 'package:student_manager/core/models/user_role.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

class UsersListResult {
  const UsersListResult({
    required this.students,
    required this.teachers,
  });

  final List<UserModel> students;
  final List<UserModel> teachers;
}

class UsersRepository {
  UsersRepository({
    FirebaseFirestore? firestore,
    UserFirestoreService? userFirestoreService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _userFirestore = userFirestoreService ?? UserFirestoreService(firestore: firestore);

  final FirebaseFirestore _firestore;
  final UserFirestoreService _userFirestore;

  static const defaultUserPassword = 'Student123!';
  static const _serverTimeout = Duration(seconds: 6);
  static const _cacheTimeout = Duration(milliseconds: 800);

  Future<UsersListResult> fetchAllUsers({bool cacheOnly = false}) async {
    final source = cacheOnly ? Source.cache : Source.serverAndCache;

    try {
      final snapshot = await _firestore
          .collection(UserFirestoreService.usersCollection)
          .get(GetOptions(source: source))
          .timeout(cacheOnly ? _cacheTimeout : _serverTimeout);

      return _splitByRole(snapshot);
    } on TimeoutException catch (e, stackTrace) {
      AppLogger.error('UsersRepository', 'Fetch users timeout (cacheOnly: $cacheOnly)', e, stackTrace);

      if (!cacheOnly) {
        return fetchAllUsers(cacheOnly: true);
      }
      return const UsersListResult(students: [], teachers: []);
    } catch (e, stackTrace) {
      AppLogger.error('UsersRepository', 'Fetch users failed', e, stackTrace);

      if (!cacheOnly) {
        try {
          return await fetchAllUsers(cacheOnly: true);
        } catch (_) {}
      }
      return const UsersListResult(students: [], teachers: []);
    }
  }

  UsersListResult _splitByRole(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final students = <UserModel>[];
    final teachers = <UserModel>[];

    for (final doc in snapshot.docs) {
      final user = UserModel.fromFirestore(uid: doc.id, data: doc.data());
      switch (user.role) {
        case UserRole.student:
          students.add(user);
        case UserRole.teacher:
          teachers.add(user);
        case UserRole.admin:
          break;
      }
    }

    students.sort((a, b) => a.displayName.compareTo(b.displayName));
    teachers.sort((a, b) => a.displayName.compareTo(b.displayName));

    return UsersListResult(students: students, teachers: teachers);
  }

  Future<List<UserModel>> fetchStudentsByIds(List<String> ids) async {
    if (ids.isEmpty) return [];

    final students = <UserModel>[];
    for (final id in ids) {
      try {
        final doc = await _firestore
            .collection(UserFirestoreService.usersCollection)
            .doc(id)
            .get(const GetOptions(source: Source.serverAndCache));
        if (!doc.exists || doc.data() == null) continue;
        final user = UserModel.fromFirestore(uid: doc.id, data: doc.data()!);
        if (user.role == UserRole.student) {
          students.add(user);
        }
      } catch (e, stackTrace) {
        AppLogger.error('UsersRepository', 'Fetch student $id failed', e, stackTrace);
      }
    }

    students.sort((a, b) => a.displayName.compareTo(b.displayName));
    return students;
  }

  Future<List<UserModel>> fetchStudentsByGroupId(String groupId) async {
    try {
      final snapshot = await _firestore
          .collection(UserFirestoreService.usersCollection)
          .where('groupId', isEqualTo: groupId)
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(_serverTimeout);

      final students = snapshot.docs
          .map((doc) => UserModel.fromFirestore(uid: doc.id, data: doc.data()))
          .where((user) => user.role == UserRole.student)
          .toList()
        ..sort((a, b) => a.displayName.compareTo(b.displayName));

      return students;
    } catch (e, stackTrace) {
      AppLogger.error('UsersRepository', 'Fetch students by groupId failed', e, stackTrace);
      return [];
    }
  }

  Future<List<UserModel>> fetchStudentsForGroup({
    required String groupId,
    required List<String> memberIds,
  }) async {
    final byGroupId = await fetchStudentsByGroupId(groupId);
    if (byGroupId.isNotEmpty) return byGroupId;

    return fetchStudentsByIds(memberIds);
  }

  Future<UserModel> createUser({
    required String email,
    required String displayName,
    required String password,
    required UserRole role,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedName = displayName.trim();

    AppLogger.info('UsersRepository', 'Create user: $normalizedEmail as ${role.name}');

    final existingProfile = await _userFirestore.findUserByEmail(normalizedEmail);
    if (existingProfile != null) {
      return _assignRoleToExistingProfile(
        existing: existingProfile,
        displayName: normalizedName,
        role: role,
      );
    }

    final secondaryAuth = await SecondaryFirebaseAuth.instance();

    try {
      final credential = await secondaryAuth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw const AuthException('auth-failed');
      }

      final model = UserModel(
        uid: firebaseUser.uid,
        email: normalizedEmail,
        displayName: normalizedName,
        role: role,
      );

      await _userFirestore.saveUser(model);
      await secondaryAuth.signOut();

      AppLogger.info('UsersRepository', 'User created with role ${role.name}: ${model.uid}');
      return model;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return _linkExistingAuthAccount(
          secondaryAuth: secondaryAuth,
          email: normalizedEmail,
          displayName: normalizedName,
          password: password,
          role: role,
        );
      }

      await secondaryAuth.signOut();
      AppLogger.error('UsersRepository', 'Create user auth error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    } on AuthException {
      await secondaryAuth.signOut();
      rethrow;
    }
  }

  Future<UserModel> _assignRoleToExistingProfile({
    required UserModel existing,
    required String displayName,
    required UserRole role,
  }) async {
    if (existing.role == UserRole.admin) {
      throw const AuthException('cannot-modify-admin');
    }

    if (existing.role == role) {
      AppLogger.info('UsersRepository', 'User already has role ${role.name}: ${existing.uid}');
      return existing;
    }

    final updated = UserModel(
      uid: existing.uid,
      email: existing.email,
      displayName: displayName.isNotEmpty ? displayName : existing.displayName,
      role: role,
    );

    await _userFirestore.saveUser(updated);
    AppLogger.info('UsersRepository', 'User role updated to ${role.name}: ${updated.uid}');
    return updated;
  }

  Future<UserModel> _linkExistingAuthAccount({
    required FirebaseAuth secondaryAuth,
    required String email,
    required String displayName,
    required String password,
    required UserRole role,
  }) async {
    AppLogger.info('UsersRepository', 'Auth exists, linking profile: $email');

    try {
      final credential = await secondaryAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw const AuthException('auth-failed');
      }

      final model = UserModel(
        uid: firebaseUser.uid,
        email: email,
        displayName: displayName,
        role: role,
      );

      await _userFirestore.saveUser(model);
      await secondaryAuth.signOut();

      AppLogger.info('UsersRepository', 'Linked existing auth to role ${role.name}: ${model.uid}');
      return model;
    } on FirebaseAuthException catch (e) {
      await secondaryAuth.signOut();

      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw const AuthException('email-already-in-use-other-password');
      }

      AppLogger.error('UsersRepository', 'Link auth account error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    } on AuthException {
      await secondaryAuth.signOut();
      rethrow;
    }
  }
}
