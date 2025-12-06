import '../../domain/entities/freelancer_stats_entity.dart';

class FreelancerStatsModel extends FreelancerStatsEntity {
  const FreelancerStatsModel({
    required super.totalEarnings,
    required super.activeOrders,
    required super.profileViews,
    required super.rating,
    required super.isOnline,
  });

  factory FreelancerStatsModel.fromJson(Map<String, dynamic> json) {
    return FreelancerStatsModel(
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      activeOrders: json['activeOrders'] as int,
      profileViews: json['profileViews'] as int,
      rating: (json['rating'] as num).toDouble(),
      isOnline: json['isOnline'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEarnings': totalEarnings,
      'activeOrders': activeOrders,
      'profileViews': profileViews,
      'rating': rating,
      'isOnline': isOnline,
    };
  }

  FreelancerStatsModel copyWith({
    double? totalEarnings,
    int? activeOrders,
    int? profileViews,
    double? rating,
    bool? isOnline,
  }) {
    return FreelancerStatsModel(
      totalEarnings: totalEarnings ?? this.totalEarnings,
      activeOrders: activeOrders ?? this.activeOrders,
      profileViews: profileViews ?? this.profileViews,
      rating: rating ?? this.rating,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
