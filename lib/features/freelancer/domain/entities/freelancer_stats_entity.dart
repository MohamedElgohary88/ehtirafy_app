import 'package:equatable/equatable.dart';

class FreelancerStatsEntity extends Equatable {
  final double totalEarnings;
  final int activeOrders;
  final int profileViews;
  final double rating;
  final bool isOnline;

  const FreelancerStatsEntity({
    required this.totalEarnings,
    required this.activeOrders,
    required this.profileViews,
    required this.rating,
    required this.isOnline,
  });

  @override
  List<Object?> get props => [
    totalEarnings,
    activeOrders,
    profileViews,
    rating,
    isOnline,
  ];
}
