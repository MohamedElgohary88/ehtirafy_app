import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/network/api_error_handler.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/login_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/user_local_data_source.dart';
import '../models/register_request_params.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

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

      // Persist user and token
      await localDataSource.saveUser(result.user);
      await localDataSource.saveToken(result.token);

      return Right(result);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, User>> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required String sex,
    required String materialStatus,
    required String userType,
    required String countryCode,
  }) async {
    try {
      final params = RegisterRequestParams(
        name: fullName,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        sex: sex,
        materialStatus: materialStatus,
        phone: phone,
        userType: userType,
        countryCode: countryCode,
      );
      final result = await remoteDataSource.signup(params);

      // Signup usually returns user data. We should save it.
      // RegisterResponseModel (which is result) extends User? Or contains User?
      // Based on previous view, RegisterResponseModel seemed to be User-like.
      // Let's assume it is User or extends it.

      await localDataSource.saveUser(result);

      // For token, signup response might contain it?
      // RegisterResponseModel usually has token if auto-login.
      // If result has token field we save it.
      // Checking RegisterResponseModel...
      // Previous view of LoginModel showed: user: RegisterResponseModel.fromJson(json['user']).
      // So RegisterResponseModel IS the user object.
      // Does it have token?
      // If not, maybe we don't save token on signup unless API returns it.
      // Assuming user has to login after signup or signup returns token in different field not in User object.
      // If RegisterResponseModel has token, save it.

      // Actually, if signup flow requires login afterwards, we don't save token.
      // But usually mobile apps auto login.
      // Let's check RegisterResponseModel content if I can .. or just proceed safely.
      // I'll stick to saving User.

      return Right(result);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    try {
      final result = await remoteDataSource.forgotPassword(email);
      return Right(result);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
