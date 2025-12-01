import 'package:dartz/dartz.dart';
import '../entities/login_result.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repo;
  SignupUseCase(this.repo);

  Future<Either<String, LoginResult>> call({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    return repo.signup(fullName: fullName, email: email, phone: phone, password: password);
  }
}

