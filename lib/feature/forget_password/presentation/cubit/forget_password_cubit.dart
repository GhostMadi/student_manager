import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/feature/forget_password/data/repository/password_reset_repository.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

class ForgetPasswordState {
  const ForgetPasswordState({
    this.step = 'email',
    this.isLoading = false,
    this.errorCode,
    this.email = '',
  });

  final String step;
  final bool isLoading;
  final String? errorCode;
  final String email;

  bool get isEmailStep => step == 'email';
  bool get isSuccessStep => step == 'success';

  ForgetPasswordState copyWith({
    String? step,
    bool? isLoading,
    String? errorCode,
    String? email,
    bool clearError = false,
  }) {
    return ForgetPasswordState(
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
      email: email ?? this.email,
    );
  }
}

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit({PasswordResetRepository? passwordResetRepository})
      : _repository = passwordResetRepository ?? PasswordResetRepository(),
        super(const ForgetPasswordState());

  final PasswordResetRepository _repository;

  Future<void> sendResetEmail(String email) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      await _repository.sendResetEmail(email);
      emit(
        state.copyWith(
          isLoading: false,
          step: 'success',
          email: email.trim(),
        ),
      );
    } on AuthException catch (e) {
      emit(state.copyWith(isLoading: false, errorCode: e.code));
    } catch (_) {
      emit(state.copyWith(isLoading: false, errorCode: 'unknown'));
    }
  }

  void goBackToEmail() {
    emit(state.copyWith(step: 'email', clearError: true));
  }

  void clearError() {
    if (state.errorCode != null) {
      emit(state.copyWith(clearError: true));
    }
  }

  void reset() {
    emit(const ForgetPasswordState());
  }
}
