import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

/// Единый слой записи/чтения профиля пользователя в Firestore.
/// Роль (student / teacher / admin) определяется только документом users/{uid}.
class UserFirestoreService {
  UserFirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const usersCollection = 'users';
  static const readTimeout = Duration(seconds: 6);
  static const writeTimeout = Duration(seconds: 8);

  Future<void> saveUser(UserModel user) async {
    AppLogger.info('UserFirestoreService', 'Save profile: ${user.uid} as ${user.role.name}');

    try {
      await _firestore.collection(usersCollection).doc(user.uid).set({
        ...user.toFirestore(),
        'updatedAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)).timeout(writeTimeout);

      AppLogger.info('UserFirestoreService', 'Profile saved: ${user.uid}');
    } on FirebaseException catch (e, stackTrace) {
      AppLogger.error('UserFirestoreService', 'Save failed: ${e.code}', e, stackTrace);
      throw AuthException(e.code, message: e.message);
    } on TimeoutException catch (e, stackTrace) {
      AppLogger.error('UserFirestoreService', 'Save timeout', e, stackTrace);
      throw const AuthException('deadline-exceeded');
    }
  }

  Future<UserModel?> findUserByEmail(String email) async {
    final normalizedEmail = email.trim().toLowerCase();

    try {
      final snapshot = await _firestore
          .collection(usersCollection)
          .where('email', isEqualTo: normalizedEmail)
          .limit(1)
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(readTimeout);

      if (snapshot.docs.isEmpty) return null;

      final doc = snapshot.docs.first;
      return UserModel.fromFirestore(uid: doc.id, data: doc.data());
    } on FirebaseException catch (e, stackTrace) {
      AppLogger.error('UserFirestoreService', 'Find by email failed: ${e.code}', e, stackTrace);
      throw AuthException(e.code, message: e.message);
    } on TimeoutException catch (e, stackTrace) {
      AppLogger.error('UserFirestoreService', 'Find by email timeout', e, stackTrace);
      throw const AuthException('deadline-exceeded');
    }
  }

  Future<void> updateGroupId(String uid, String? groupId) async {
    try {
      await _firestore.collection(usersCollection).doc(uid).set({
        'groupId': groupId ?? FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)).timeout(writeTimeout);
    } on FirebaseException catch (e, stackTrace) {
      AppLogger.error('UserFirestoreService', 'Update groupId failed: ${e.code}', e, stackTrace);
      throw AuthException(e.code, message: e.message);
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      final doc = await _firestore
          .collection(usersCollection)
          .doc(uid)
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(readTimeout);

      if (!doc.exists || doc.data() == null) {
        throw const AuthException('profile-not-found');
      }

      final user = UserModel.fromFirestore(uid: uid, data: doc.data()!);
      AppLogger.info('UserFirestoreService', 'Profile loaded: $uid → ${user.role.name}');
      return user;
    } on AuthException {
      rethrow;
    } on FirebaseException catch (e, stackTrace) {
      AppLogger.error('UserFirestoreService', 'Get failed: ${e.code}', e, stackTrace);
      throw AuthException(e.code, message: e.message);
    } on TimeoutException catch (e, stackTrace) {
      AppLogger.error('UserFirestoreService', 'Get timeout', e, stackTrace);
      throw const AuthException('deadline-exceeded');
    }
  }
}
