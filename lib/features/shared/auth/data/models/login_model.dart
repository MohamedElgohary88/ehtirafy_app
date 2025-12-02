import '../../domain/entities/login_result.dart';

class LoginModel extends LoginResult {
  const LoginModel({required super.token, required super.userName});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] ?? '',
      userName: json['user_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'user_name': userName};
  }
}
