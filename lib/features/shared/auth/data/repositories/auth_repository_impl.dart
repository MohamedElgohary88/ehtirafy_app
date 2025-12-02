import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import '../../domain/entities/login_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginResult>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('failures.server'));
    }
  }

  @override
  Future<Either<Failure, LoginResult>> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.signup(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('failures.server'));
    }
  }
}
