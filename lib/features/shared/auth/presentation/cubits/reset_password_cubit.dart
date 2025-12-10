import 'package:bloc/bloc.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/repositories/auth_repository.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordCubit(this._authRepository) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(ResetPasswordLoading());

    final result = await _authRepository.resetPassword(
      email: email,
      otp: otp,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    result.fold(
      (failure) => emit(ResetPasswordError(failure.message)),
      (message) => emit(ResetPasswordSuccess(message)),
    );
  }
}
