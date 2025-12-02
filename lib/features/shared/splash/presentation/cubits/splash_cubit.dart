import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> initSplash() async {
    emit(SplashLoading());
    // Simulate initialization delay (e.g., checking auth, loading configs)
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Check authentication status here
    // if (isLoggedIn) {
    //   emit(SplashNavigateToHome());
    // } else {
    emit(SplashNavigateToOnboarding());
    // }
  }
}
