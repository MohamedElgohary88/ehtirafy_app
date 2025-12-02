import 'package:equatable/equatable.dart';
import '../../domain/entities/login_result.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final LoginResult result;

  const SignupSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class SignupError extends SignupState {
  final String failureKey;

  const SignupError(this.failureKey);

  @override
  List<Object> get props => [failureKey];
}
