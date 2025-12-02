import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import '../entities/login_result.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);

  Future<Either<Failure, LoginResult>> call({
    required String email,
    required String password,
  }) {
    return repo.login(email: email, password: password);
  }
}
