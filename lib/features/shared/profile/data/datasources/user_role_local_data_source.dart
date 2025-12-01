import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_role.dart';

/// Local data source for user role using SharedPreferences
abstract class UserRoleLocalDataSource {
  Future<UserRole?> getCachedRole();
  Future<void> cacheRole(UserRole role);
  Future<void> clearCachedRole();
}

class UserRoleLocalDataSourceImpl implements UserRoleLocalDataSource {
  static const String _roleKey = 'USER_ROLE';
  final SharedPreferences sharedPreferences;

  UserRoleLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserRole?> getCachedRole() async {
    final roleString = sharedPreferences.getString(_roleKey);
    if (roleString == null) return null;

    return UserRole.values.firstWhere(
      (role) => role.name == roleString,
      orElse: () => UserRole.guest,
    );
  }

  @override
  Future<void> cacheRole(UserRole role) async {
    await sharedPreferences.setString(_roleKey, role.name);
  }

  @override
  Future<void> clearCachedRole() async {
    await sharedPreferences.remove(_roleKey);
  }
}

