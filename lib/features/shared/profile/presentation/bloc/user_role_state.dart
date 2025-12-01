import 'package:equatable/equatable.dart';
import '../../domain/entities/user_role.dart';

/// States for UserRoleCubit
abstract class UserRoleState extends Equatable {
  const UserRoleState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class UserRoleInitial extends UserRoleState {}

/// Loading state
class UserRoleLoading extends UserRoleState {}

/// Loaded state with current role
class UserRoleLoaded extends UserRoleState {
  final UserRoleEntity roleEntity;

  const UserRoleLoaded(this.roleEntity);

  @override
  List<Object?> get props => [roleEntity];
}

/// Error state
class UserRoleError extends UserRoleState {
  final String message;

  const UserRoleError(this.message);

  @override
  List<Object?> get props => [message];
}

