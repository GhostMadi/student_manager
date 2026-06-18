import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';
import 'package:student_manager/feature/register_page/data/repository/register_repository.dart';

class RegisterState {
  const RegisterState({
    this.isLoading = false,
    this.errorCode,
    this.user,
  });

  final bool isLoading;
  final String? errorCode;
  final UserModel? user;

  bool get isSuccess => user != null;

  RegisterState copyWith({
    bool? isLoading,
    String? errorCode,
    UserModel? user,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
      user: clearUser ? null : (user ?? this.user),
    );
  }
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({RegisterRepository? registerRepository})
      : _registerRepository = registerRepository ?? RegisterRepository(),
        super(const RegisterState());

  final RegisterRepository _registerRepository;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    AppLogger.info('RegisterCubit', 'Register requested: ${email.trim()}');
    emit(state.copyWith(isLoading: true, clearError: true, clearUser: true));

    UserModel? user;
    String? errorCode;

    try {
      user = await _registerRepository.register(
        email: email,
        password: password,
        displayName: name,
      );
      AppLogger.info('RegisterCubit', 'Register completed: ${user.uid}');
    } on AuthException catch (e) {
      AppLogger.error('RegisterCubit', 'AuthException: ${e.code}', e);
      errorCode = e.code;
    } on FirebaseException catch (e) {
      AppLogger.error('RegisterCubit', 'FirebaseException: ${e.code}', e);
      errorCode = e.code;
    } catch (e, stackTrace) {
      AppLogger.error('RegisterCubit', 'Unexpected register error', e, stackTrace);
      errorCode = 'unknown';
    } finally {
      if (!isClosed) {
        emit(
          RegisterState(
            isLoading: false,
            errorCode: errorCode,
            user: user,
          ),
        );
        AppLogger.info(
          'RegisterCubit',
          'State updated: loading=false, success=${user != null}, error=$errorCode',
        );
      }
    }
  }

  void clearError() {
    if (state.errorCode != null) {
      emit(state.copyWith(clearError: true));
    }
  }

  void reset() {
    emit(const RegisterState());
  }
}
