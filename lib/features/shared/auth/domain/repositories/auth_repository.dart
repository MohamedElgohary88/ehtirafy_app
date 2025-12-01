import 'package:dartz/dartz.dart';
import '../entities/login_result.dart';

abstract class AuthRepository {
  Future<Either<String, LoginResult>> login({required String email, required String password});
}

