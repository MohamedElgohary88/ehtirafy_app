import 'package:equatable/equatable.dart';

/// Enum representing the user roles in the app
enum UserRole {
  client,
  freelancer,
  guest; // For unauthenticated users

  String get displayName {
    switch (this) {
      case UserRole.client:
        return 'عميل'; // Client in Arabic
      case UserRole.freelancer:
        return 'مصور محترف'; // Freelancer in Arabic
      case UserRole.guest:
        return 'ضيف'; // Guest in Arabic
    }
  }

  String get route {
    switch (this) {
      case UserRole.client:
        return '/client';
      case UserRole.freelancer:
        return '/freelancer';
      case UserRole.guest:
        return '/auth';
    }
  }
}

/// Entity representing the current user role state
class UserRoleEntity extends Equatable {
  final UserRole role;
  final bool isAuthenticated;

  const UserRoleEntity({
    required this.role,
    required this.isAuthenticated,
  });

  const UserRoleEntity.guest()
      : role = UserRole.guest,
        isAuthenticated = false;

  const UserRoleEntity.client()
      : role = UserRole.client,
        isAuthenticated = true;

  const UserRoleEntity.freelancer()
      : role = UserRole.freelancer,
        isAuthenticated = true;

  UserRoleEntity copyWith({
    UserRole? role,
    bool? isAuthenticated,
  }) {
    return UserRoleEntity(
      role: role ?? this.role,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [role, isAuthenticated];
}

