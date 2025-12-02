import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import '../entities/login_result.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repo;
  SignupUseCase(this.repo);

  Future<Either<Failure, LoginResult>> call({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    return repo.signup(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
  }
}
