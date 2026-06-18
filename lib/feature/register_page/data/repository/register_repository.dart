import 'package:student_manager/feature/login_page/data/model/user_model.dart';
import 'package:student_manager/feature/login_page/data/repository/auth_repository.dart';

class RegisterRepository {
  RegisterRepository({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  final AuthRepository _authRepository;

  Future<UserModel> register({
    required String email,
    required String password,
    required String displayName,
  }) {
    return _authRepository.register(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
