import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ehtirafy_app/features/shared/auth/data/datasources/user_local_data_source.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/entities/user_role.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/usecases/role_usecases.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final UserLocalDataSource userLocalDataSource;
  final GetRoleUseCase getRoleUseCase;

  SplashCubit({required this.userLocalDataSource, required this.getRoleUseCase})
    : super(SplashInitial());

  Future<void> initSplash() async {
    emit(SplashLoading());

    try {
      // No delay needed as native splash handles branding

      // Check for saved token
      final token = await userLocalDataSource.getToken();

      if (token != null && token.isNotEmpty) {
        // User is authenticated, check their role
        final roleResult = await getRoleUseCase.call();

        roleResult.fold(
          (failure) {
            // If role fetch fails, default to client home
            emit(SplashNavigateToHome());
          },
          (role) {
            if (role == UserRole.freelancer) {
              emit(SplashNavigateToFreelancerDashboard());
            } else {
              emit(SplashNavigateToHome());
            }
          },
        );
      } else {
        // No token, go to onboarding
        emit(SplashNavigateToOnboarding());
      }
    } catch (e) {
      // On any error, navigate to onboarding as fallback
      emit(SplashNavigateToOnboarding());
    }
  }
}
