enum UserRole { client, freelancer }

class UserProfileEntity {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final String phone;
  final UserRole currentRole;

  // Freelancer specific fields
  final double? rating;
  final int? reviewCount;
  final String? bio;

  const UserProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.phone,
    required this.currentRole,
    this.rating,
    this.reviewCount,
    this.bio,
  });

  UserProfileEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? phone,
    UserRole? currentRole,
    double? rating,
    int? reviewCount,
    String? bio,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      currentRole: currentRole ?? this.currentRole,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      bio: bio ?? this.bio,
    );
  }
}
