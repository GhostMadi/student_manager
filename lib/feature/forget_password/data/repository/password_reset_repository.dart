import 'package:student_manager/feature/login_page/data/repository/auth_repository.dart';

class PasswordResetRepository {
  PasswordResetRepository({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository();

  final AuthRepository _authRepository;

  Future<void> sendResetEmail(String email) {
    return _authRepository.sendPasswordResetEmail(email);
  }
}
