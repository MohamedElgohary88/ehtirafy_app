import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/switch_user_role_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final SwitchUserRoleUseCase switchUserRoleUseCase;

  ProfileCubit({
    required this.getUserProfileUseCase,
    required this.switchUserRoleUseCase,
  }) : super(ProfileInitial());

  Future<void> loadUserProfile() async {
    emit(ProfileLoading());
    final result = await getUserProfileUseCase();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (userProfile) => emit(ProfileLoaded(userProfile)),
    );
  }

  Future<void> toggleRole() async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileRoleSwitching(currentState.userProfile));

      final currentRole = currentState.userProfile.currentRole;
      final newRole = currentRole == UserRole.client
          ? UserRole.freelancer
          : UserRole.client;

      final result = await switchUserRoleUseCase(newRole);
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (updatedProfile) => emit(ProfileLoaded(updatedProfile)),
      );
    }
  }
}
