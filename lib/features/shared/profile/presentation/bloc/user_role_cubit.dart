import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_role.dart';
import '../../domain/usecases/get_current_role.dart';
import '../../domain/usecases/switch_user_role.dart';
import '../../domain/repositories/user_role_repository.dart';
import 'user_role_state.dart';

/// Cubit for managing user role state
class UserRoleCubit extends Cubit<UserRoleState> {
  final GetCurrentRole getCurrentRole;
  final SwitchUserRole switchUserRole;
  final UserRoleRepository repository;

  UserRoleCubit({
    required this.getCurrentRole,
    required this.switchUserRole,
    required this.repository,
  }) : super(UserRoleInitial()) {
    // Load current role on initialization
    loadCurrentRole();

    // Listen to role changes
    repository.watchRoleChanges().listen((roleEntity) {
      emit(UserRoleLoaded(roleEntity));
    });
  }

  /// Load the current user role
  Future<void> loadCurrentRole() async {
    emit(UserRoleLoading());

    final result = await getCurrentRole();

    result.fold(
      (failure) => emit(UserRoleError(failure.message)),
      (roleEntity) => emit(UserRoleLoaded(roleEntity)),
    );
  }

  /// Switch to a different role
  Future<void> switchRole(UserRole newRole) async {
    // Optimistically update UI
    if (state is UserRoleLoaded) {
      final currentEntity = (state as UserRoleLoaded).roleEntity;
      emit(UserRoleLoaded(currentEntity.copyWith(role: newRole)));
    }

    final result = await switchUserRole(newRole);

    result.fold(
      (failure) {
        emit(UserRoleError(failure.message));
        // Reload to get back to the correct state
        loadCurrentRole();
      },
      (roleEntity) => emit(UserRoleLoaded(roleEntity)),
    );
  }

  /// Logout (clear role)
  Future<void> logout() async {
    await repository.clearRole();
    emit(const UserRoleLoaded(UserRoleEntity.guest()));
  }

  /// Check if user is authenticated
  bool get isAuthenticated {
    if (state is UserRoleLoaded) {
      return (state as UserRoleLoaded).roleEntity.isAuthenticated;
    }
    return false;
  }

  /// Get current role
  UserRole? get currentRole {
    if (state is UserRoleLoaded) {
      return (state as UserRoleLoaded).roleEntity.role;
    }
    return null;
  }

  /// Check if current role is client
  bool get isClient => currentRole == UserRole.client;

  /// Check if current role is freelancer
  bool get isFreelancer => currentRole == UserRole.freelancer;

  /// Check if current role is guest
  bool get isGuest => currentRole == UserRole.guest || !isAuthenticated;
}

