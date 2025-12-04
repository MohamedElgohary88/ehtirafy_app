import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.avatarUrl,
    required super.phone,
    required super.currentRole,
    super.rating,
    super.reviewCount,
    super.bio,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      phone: json['phone'],
      currentRole: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == json['currentRole'],
        orElse: () => UserRole.client,
      ),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'phone': phone,
      'currentRole': currentRole.toString().split('.').last,
      'rating': rating,
      'reviewCount': reviewCount,
      'bio': bio,
    };
  }
}
