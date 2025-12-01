import 'package:bloc/bloc.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/usecases/login_usecase.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/entities/login_result.dart';

// States
abstract class LoginState {
  const LoginState();
}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final LoginResult result;
  const LoginSuccess(this.result);
}
class LoginError extends LoginState {
  final String failureKey; // localization key
  const LoginError(this.failureKey);
}

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _usecase;
  LoginCubit(this._usecase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(const LoginError('failures.validation'));
      return;
    }
    emit(LoginLoading());
    final result = await _usecase.call(email: email, password: password);
    result.fold(
      (failureKey) => emit(LoginError(failureKey)),
      (data) => emit(LoginSuccess(data)),
    );
  }
}
