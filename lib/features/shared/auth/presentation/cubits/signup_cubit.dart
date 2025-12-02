import 'package:bloc/bloc.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;

  SignupCubit(this.signupUseCase) : super(SignupInitial());

  Future<void> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(SignupLoading());
    final result = await signupUseCase(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
    result.fold(
      (failure) => emit(SignupError(_mapFailureToMessage(failure))),
      (loginResult) => emit(SignupSuccess(loginResult)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return AppStrings.failureServer;
    if (failure is CacheFailure) return AppStrings.failureCache;
    if (failure is NetworkFailure) return AppStrings.failureNetwork;
    return AppStrings.failureUnexpected;
  }
}
