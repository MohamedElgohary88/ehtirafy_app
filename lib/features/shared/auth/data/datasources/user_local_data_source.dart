import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(User user);
  Future<User?> getUser();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearUserData();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  static const String _userKey = 'cached_user';
  static const String _tokenKey = 'cached_token';

  @override
  Future<void> saveUser(User user) async {
    // Assuming User has a toJson method via UserModel or we convert it manually.
    // Ideally we should save UserModel.
    // If User is entity, we need to cast to UserModel or map it.
    // Let's assume we can convert it to map.
    // Since UserModel likely extends User, we might need to rely on UserModel here.
    // But interface uses User. We will check UserModel in next steps.
    // specific implementation depends on UserModel availability.

    // Quick fix: user UserModel.fromEntity(user) if exists or cast.
    // For now I will assume passed user is UserModel or I can create one.

    // We can rely on a utility or model. Since UserModel was not found, let's use a simple Map for now or define a local model if needed.
    // However, we need to be consistent.
    // If we look at LoginModel (which I will inspect right now), it might contain the User parsing logic.
    // For now, I'll store the basic fields available in User entity to avoid errors.

    final userData = {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'country_code': user.countryCode,
      'sex': user.sex,
      'material_status': user.materialStatus,
      // 'user_type': user.userType, // Not in User entity apparently?
      // 'city_id': user.cityId,
      // 'city_name': user.cityName,
      // 'profile_image': user.profileImage,
    };

    await sharedPreferences.setString(_userKey, json.encode(userData));
  }

  @override
  Future<User?> getUser() async {
    final jsonString = sharedPreferences.getString(_userKey);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return User(
        id: jsonMap['id'],
        name: jsonMap['name'],
        email: jsonMap['email'],
        phone: jsonMap['phone'],
        countryCode: jsonMap['country_code'],
        sex: jsonMap['sex'],
        materialStatus: jsonMap['material_status'],
      );
    }
    return null;
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(_tokenKey);
  }

  @override
  Future<void> clearUserData() async {
    await sharedPreferences.remove(_userKey);
    await sharedPreferences.remove(_tokenKey);
  }
}
