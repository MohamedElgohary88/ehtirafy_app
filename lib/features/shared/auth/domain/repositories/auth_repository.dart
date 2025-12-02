import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import '../entities/login_result.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResult>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, LoginResult>> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });
}
