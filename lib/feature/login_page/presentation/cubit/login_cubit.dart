import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/models/user_role.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';
import 'package:student_manager/feature/login_page/data/repository/auth_repository.dart';
import 'package:student_manager/core/config/admin_credentials.dart';

class LoginState {
  const LoginState({
    this.isLoading = false,
    this.errorCode,
    this.user,
    this.adminAlreadyExists = false,
    this.adminCreated = false,
  });

  final bool isLoading;
  final String? errorCode;
  final UserModel? user;
  final bool adminAlreadyExists;
  final bool adminCreated;

  bool get isSuccess => user != null;

  LoginState copyWith({
    bool? isLoading,
    String? errorCode,
    UserModel? user,
    bool? adminAlreadyExists,
    bool? adminCreated,
    bool clearError = false,
    bool clearUser = false,
    bool clearAdminCreated = false,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
      user: clearUser ? null : (user ?? this.user),
      adminAlreadyExists: adminAlreadyExists ?? this.adminAlreadyExists,
      adminCreated: clearAdminCreated ? false : (adminCreated ?? this.adminCreated),
    );
  }
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository(),
        super(const LoginState());

  final AuthRepository _authRepository;

  Future<void> checkAdminBootstrap() async {
    final exists = await _authRepository.adminExists();
    if (!isClosed) {
      emit(state.copyWith(adminAlreadyExists: exists));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    AppLogger.info('LoginCubit', 'Login requested: ${email.trim()}');
    emit(state.copyWith(isLoading: true, clearError: true, clearUser: true, clearAdminCreated: true));

    UserModel? user;
    String? errorCode;

    try {
      user = await _authRepository.login(email: email, password: password);
      AppLogger.info('LoginCubit', 'Login completed: ${user.uid}');
    } on AuthException catch (e) {
      AppLogger.error('LoginCubit', 'AuthException: ${e.code}', e);
      errorCode = e.code;
    } on FirebaseException catch (e) {
      AppLogger.error('LoginCubit', 'FirebaseException: ${e.code}', e);
      errorCode = e.code;
    } catch (e, stackTrace) {
      AppLogger.error('LoginCubit', 'Unexpected login error', e, stackTrace);
      errorCode = 'unknown';
    } finally {
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            errorCode: errorCode,
            user: user,
          ),
        );
      }
    }
  }

  Future<void> createBootstrapAdmin() async {
    AppLogger.info('LoginCubit', 'Create bootstrap admin requested');
    emit(state.copyWith(isLoading: true, clearError: true, clearUser: true, clearAdminCreated: true));

    UserModel? user;
    String? errorCode;
    var adminAlreadyExists = state.adminAlreadyExists;
    var adminCreated = false;

    try {
      user = await _authRepository.createBootstrapAdmin(
        email: AdminCredentials.email,
        password: AdminCredentials.password,
        displayName: AdminCredentials.displayName,
      );
      adminAlreadyExists = true;
      adminCreated = true;
      AppLogger.info('LoginCubit', 'Bootstrap admin created: ${user.uid}');
    } on AuthException catch (e) {
      AppLogger.error('LoginCubit', 'AuthException: ${e.code}', e);
      errorCode = e.code;
      if (e.code == 'admin-already-exists') {
        adminAlreadyExists = true;
      }
    } on FirebaseException catch (e) {
      AppLogger.error('LoginCubit', 'FirebaseException: ${e.code}', e);
      errorCode = e.code;
    } catch (e, stackTrace) {
      AppLogger.error('LoginCubit', 'Unexpected admin create error', e, stackTrace);
      errorCode = 'unknown';
    } finally {
      if (!isClosed) {
        emit(
          LoginState(
            isLoading: false,
            errorCode: errorCode,
            user: user,
            adminAlreadyExists: adminAlreadyExists,
            adminCreated: adminCreated,
          ),
        );
      }
    }
  }

  Future<UserRole?> restoreSession() async {
    try {
      final user = await _authRepository.restoreSession();
      if (user == null) {
        emit(const LoginState());
        return null;
      }
      emit(state.copyWith(user: user, clearError: true, clearAdminCreated: true));
      return user.role;
    } catch (e, stackTrace) {
      AppLogger.error('LoginCubit', 'Restore session failed', e, stackTrace);
      emit(const LoginState());
      return null;
    }
  }

  void clearSession() {
    emit(const LoginState());
  }

  void clearError() {
    if (state.errorCode != null) {
      emit(state.copyWith(clearError: true));
    }
  }

  void clearAdminCreated() {
    if (state.adminCreated) {
      emit(state.copyWith(clearAdminCreated: true));
    }
  }
}
