import 'package:bloc/bloc.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/entities/login_result.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/usecases/login_usecase.dart';

abstract class SignupState { const SignupState(); }
class SignupInitial extends SignupState {}
class SignupLoading extends SignupState {}
class SignupSuccess extends SignupState { final LoginResult result; const SignupSuccess(this.result); }
class SignupError extends SignupState { final String failureKey; const SignupError(this.failureKey); }

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _usecase;
  SignupCubit(this._usecase) : super(SignupInitial());

  Future<void> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (fullName.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      emit(const SignupError('failures.validation'));
      return;
    }
    emit(SignupLoading());
    final result = await _usecase.call(fullName: fullName, email: email, phone: phone, password: password);
    result.fold(
      (failureKey) => emit(SignupError(failureKey)),
      (data) => emit(SignupSuccess(data)),
    );
  }
}

