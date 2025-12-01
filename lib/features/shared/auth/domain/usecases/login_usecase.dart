import 'package:dartz/dartz.dart';
import '../entities/login_result.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);

  Future<Either<String, LoginResult>> call({required String email, required String password}) {
    return repo.login(email: email, password: password);
  }
}

