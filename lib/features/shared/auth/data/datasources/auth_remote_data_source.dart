import '../models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({required String email, required String password});
  Future<LoginModel> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    // Mock API call
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'error@test.com') {
      throw Exception('Invalid credentials');
    }
    return const LoginModel(token: 'mock_token_123', userName: 'Ahmed Mohamed');
  }

  @override
  Future<LoginModel> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    // Mock API call
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'error@test.com') {
      throw Exception('Signup failed');
    }
    return const LoginModel(token: 'mock_token_123', userName: 'Ahmed Mohamed');
  }
}
