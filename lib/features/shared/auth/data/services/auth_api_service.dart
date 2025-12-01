class AuthApiService {
  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Sample success response
    if (email.contains('@') && password.length >= 6) {
      return {
        'success': true,
        'token': 'sample_token_123',
        'userName': 'مستخدم',
      };
    }
    return {
      'success': false,
      'message': 'بيانات غير صحيحة',
    };
  }
}

