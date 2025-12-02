import 'package:bloc/bloc.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await loginUseCase(email: email, password: password);
    result.fold(
      (failure) => emit(LoginError(_mapFailureToMessage(failure))),
      (loginResult) => emit(LoginSuccess(loginResult)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return AppStrings.failureServer;
    if (failure is CacheFailure) return AppStrings.failureCache;
    if (failure is NetworkFailure) return AppStrings.failureNetwork;
    return AppStrings.failureUnexpected;
  }
}
