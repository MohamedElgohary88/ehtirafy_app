import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ehtirafy_app/core/domain/usecase.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import '../entities/login_result.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResult, LoginParams> {
  final AuthRepository repo;
  LoginUseCase(this.repo);

  @override
  Future<Either<Failure, LoginResult>> call(LoginParams params) {
    return repo.login(email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
