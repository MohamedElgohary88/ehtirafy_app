import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/entities/login_result.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/repositories/auth_repository.dart';
import 'package:ehtirafy_app/features/shared/auth/data/services/auth_api_service.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _api = sl<AuthApiService>();
  @override
  Future<Either<String, LoginResult>> login({required String email, required String password}) async {
    try {
      final res = await _api.login(email: email, password: password);
      if (res['success'] == true) {
        return Right(LoginResult(token: res['token'] as String, userName: res['userName'] as String));
      }
      return const Left('failures.authentication');
    } catch (_) {
      return const Left('failures.unexpected');
    }
  }

  @override
  Future<Either<String, LoginResult>> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final res = await _api.signup(fullName: fullName, email: email, phone: phone, password: password);
      if (res['success'] == true) {
        return Right(LoginResult(token: res['token'] as String, userName: res['userName'] as String));
      }
      return const Left('failures.validation');
    } catch (_) {
      return const Left('failures.unexpected');
    }
  }
}
