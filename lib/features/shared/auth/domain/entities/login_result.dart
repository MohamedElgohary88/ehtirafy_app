import 'package:equatable/equatable.dart';

class LoginResult extends Equatable {
  final String token;
  final String userName;

  const LoginResult({required this.token, required this.userName});

  @override
  List<Object?> get props => [token, userName];
}
