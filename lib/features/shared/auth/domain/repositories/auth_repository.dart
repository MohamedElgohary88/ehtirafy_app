import 'package:dartz/dartz.dart';
import '../entities/login_result.dart';

abstract class AuthRepository {
  Future<Either<String, LoginResult>> login({required String email, required String password});
  Future<Either<String, LoginResult>> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });
}
