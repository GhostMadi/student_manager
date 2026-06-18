import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_manager/core/config/admin_credentials.dart';
import 'package:student_manager/core/data/user_firestore_service.dart';
import 'package:student_manager/core/models/user_role.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

class AuthRepository {
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    StorageService? storageService,
    UserFirestoreService? userFirestoreService,
  })  : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storageService ?? StorageService.instance,
        _userFirestore = userFirestoreService ?? UserFirestoreService(firestore: firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final StorageService _storage;
  final UserFirestoreService _userFirestore;

  static const _firestoreReadTimeout = Duration(seconds: 3);

  User? get currentUser => _auth.currentUser;

  Future<UserModel> login({required String email, required String password}) async {
    AppLogger.info('AuthRepository', 'Login start: ${email.trim()}');

    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw const AuthException('auth-failed');
      }

      final profile = await _resolveUserProfile(firebaseUser);
      final token = await firebaseUser.getIdToken();
      await _persistSession(profile, token ?? '');

      AppLogger.info('AuthRepository', 'Login success: ${profile.uid} → ${profile.role.name}');
      return profile;
    } on FirebaseAuthException catch (e) {
      AppLogger.error('AuthRepository', 'Login auth error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    } on AuthException {
      rethrow;
    } on FirebaseException catch (e) {
      AppLogger.error('AuthRepository', 'Login firestore error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    }
  }

  Future<bool> adminExists() async {
    try {
      final snapshot = await _firestore
          .collection(UserFirestoreService.usersCollection)
          .where('role', isEqualTo: UserRole.admin.storageValue)
          .limit(1)
          .get()
          .timeout(_firestoreReadTimeout);

      return snapshot.docs.isNotEmpty;
    } catch (e, stackTrace) {
      AppLogger.error('AuthRepository', 'Admin exists check failed', e, stackTrace);
      return false;
    }
  }

  Future<UserModel> createBootstrapAdmin({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedName = displayName.trim();

    AppLogger.info('AuthRepository', 'Bootstrap admin start: $normalizedEmail');

    if (await adminExists()) {
      throw const AuthException('admin-already-exists');
    }

    if (_auth.currentUser != null) {
      await signOut();
    }

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw const AuthException('auth-failed');
      }

      try {
        await firebaseUser.updateDisplayName(normalizedName);
      } catch (e, stackTrace) {
        AppLogger.error('AuthRepository', 'Admin display name update failed', e, stackTrace);
      }

      final model = UserModel(
        uid: firebaseUser.uid,
        email: normalizedEmail,
        displayName: normalizedName,
        role: UserRole.admin,
      );

      await _userFirestore.saveUser(model);

      final token = await firebaseUser.getIdToken();
      await _persistSession(model, token ?? '');

      AppLogger.info('AuthRepository', 'Bootstrap admin created: ${model.uid}');
      return model;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return _signInExistingAdmin(
          email: normalizedEmail,
          password: password,
          displayName: normalizedName,
        );
      }
      AppLogger.error('AuthRepository', 'Bootstrap admin auth error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    } on AuthException {
      rethrow;
    } on FirebaseException catch (e) {
      AppLogger.error('AuthRepository', 'Bootstrap admin firestore error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    }
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedName = displayName.trim();

    AppLogger.info('AuthRepository', 'Register start: $normalizedEmail');

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
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
        role: UserRole.student,
      );

      await _userFirestore.saveUser(model);

      unawaited(_updateDisplayName(firebaseUser, normalizedName));

      final token = await firebaseUser.getIdToken();
      await _persistSession(model, token ?? '');

      AppLogger.info('AuthRepository', 'Register success: ${model.uid}');
      return model;
    } on FirebaseAuthException catch (e) {
      AppLogger.error('AuthRepository', 'Register auth error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    } on FirebaseException catch (e) {
      AppLogger.error('AuthRepository', 'Register firestore error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final normalizedEmail = email.trim();
    AppLogger.info('AuthRepository', 'Send password reset: $normalizedEmail');

    try {
      await _auth.sendPasswordResetEmail(
        email: normalizedEmail,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://edu-projects-8ef5c.firebaseapp.com',
          handleCodeInApp: false,
          androidPackageName: 'com.example.student_manager',
          androidInstallApp: false,
          iOSBundleId: 'com.example.studentManager',
        ),
      );
      AppLogger.info('AuthRepository', 'Password reset email sent to $normalizedEmail');
    } on FirebaseAuthException catch (e) {
      AppLogger.error('AuthRepository', 'Password reset error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    }
  }

  Future<String> verifyPasswordResetCode(String code) async {
    try {
      final email = await _auth.verifyPasswordResetCode(code.trim());
      AppLogger.info('AuthRepository', 'Reset code verified for: $email');
      return email;
    } on FirebaseAuthException catch (e) {
      AppLogger.error('AuthRepository', 'Verify reset code error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    }
  }

  Future<void> confirmPasswordReset({required String code, required String newPassword}) async {
    try {
      await _auth.confirmPasswordReset(code: code.trim(), newPassword: newPassword);
      AppLogger.info('AuthRepository', 'Password reset confirmed');
    } on FirebaseAuthException catch (e) {
      AppLogger.error('AuthRepository', 'Confirm reset error: ${e.code}', e);
      throw AuthException(e.code, message: e.message);
    }
  }

  Future<UserModel?> restoreSession() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) {
      if (_storage.isLoggedIn) {
        await _storage.logout();
      }
      return null;
    }

    try {
      final profile = await _resolveUserProfile(firebaseUser);
      final token = await firebaseUser.getIdToken();
      await _persistSession(profile, token ?? '');
      AppLogger.info('AuthRepository', 'Session restored: ${profile.uid} → ${profile.role.name}');
      return profile;
    } catch (e, stackTrace) {
      AppLogger.error('AuthRepository', 'Restore session failed', e, stackTrace);
      await signOut();
      return null;
    }
  }

  Future<void> signOut() async {
    AppLogger.info('AuthRepository', 'Sign out');
    await _auth.signOut();
    await _storage.logout();
  }

  Future<void> _updateDisplayName(User firebaseUser, String displayName) async {
    try {
      await firebaseUser.updateDisplayName(displayName);
    } catch (e, stackTrace) {
      AppLogger.error('AuthRepository', 'updateDisplayName failed', e, stackTrace);
    }
  }

  Future<void> _persistSession(UserModel user, String token) async {
    await _storage.setLoggedIn(true);
    await _storage.setUserRole(user.role);
    await _storage.setUserName(user.displayName);
    await _storage.setToken(token);
    AppLogger.info('AuthRepository', 'Session persisted: ${user.role.name}');
  }

  Future<UserModel> _resolveUserProfile(User firebaseUser) async {
    try {
      return await _userFirestore.getUser(firebaseUser.uid);
    } on AuthException catch (e) {
      if (e.code != 'profile-not-found') rethrow;
      return _recoverMissingProfile(firebaseUser);
    }
  }

  Future<UserModel> _recoverMissingProfile(User firebaseUser) async {
    final email = firebaseUser.email?.trim().toLowerCase();

    if (email == AdminCredentials.email) {
      final model = UserModel(
        uid: firebaseUser.uid,
        email: email!,
        displayName: firebaseUser.displayName ?? AdminCredentials.displayName,
        role: UserRole.admin,
      );
      await _userFirestore.saveUser(model);
      AppLogger.info('AuthRepository', 'Recovered admin Firestore profile: ${model.uid}');
      return model;
    }

    throw const AuthException('profile-not-found');
  }

  Future<UserModel> _signInExistingAdmin({
    required String email,
    required String password,
    required String displayName,
  }) async {
    AppLogger.info('AuthRepository', 'Admin auth exists, signing in to restore profile');

    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final firebaseUser = credential.user;
    if (firebaseUser == null) {
      throw const AuthException('auth-failed');
    }

    try {
      await firebaseUser.updateDisplayName(displayName);
    } catch (_) {}

    final profile = await _resolveUserProfile(firebaseUser);
    final token = await firebaseUser.getIdToken();
    await _persistSession(profile, token ?? '');
    return profile;
  }
}
