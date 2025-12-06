import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile_model.dart';
import '../../domain/entities/user_profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> switchUserRole(UserRole newRole);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  static const String _roleKey = 'USER_ROLE';
  final SharedPreferences sharedPreferences;

  ProfileRemoteDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserProfileModel> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Get persisted role from SharedPreferences
    final roleString = sharedPreferences.getString(_roleKey);
    UserRole currentRole = UserRole.client;
    if (roleString != null) {
      currentRole = UserRole.values.firstWhere(
        (role) => role.name == roleString,
        orElse: () => UserRole.client,
      );
    }

    return _getMockUser(currentRole);
  }

  @override
  Future<UserProfileModel> switchUserRole(UserRole newRole) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Persist the new role to SharedPreferences
    await sharedPreferences.setString(_roleKey, newRole.name);

    return _getMockUser(newRole);
  }

  UserProfileModel _getMockUser(UserRole role) {
    return UserProfileModel(
      id: '12345',
      name: 'أحمد محمد عبدالعال',
      email: 'ahmed@example.com',
      avatarUrl: 'https://i.pravatar.cc/300',
      phone: '+966 50 123 4567',
      currentRole: role,
      rating: 4.9,
      reviewCount: 127,
      bio:
          'مصور محترف متخصص في تصوير المناسبات والأعراس. خبرة أكثر من 5 سنوات في المجال.',
    );
  }
}
