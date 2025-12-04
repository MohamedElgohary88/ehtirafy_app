import '../models/user_profile_model.dart';
import '../../domain/entities/user_profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> switchUserRole(UserRole newRole);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  // Simulating a remote data source with in-memory state for the role
  static UserRole _currentRole = UserRole.client;

  @override
  Future<UserProfileModel> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _getMockUser(_currentRole);
  }

  @override
  Future<UserProfileModel> switchUserRole(UserRole newRole) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    _currentRole = newRole;
    return _getMockUser(_currentRole);
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
