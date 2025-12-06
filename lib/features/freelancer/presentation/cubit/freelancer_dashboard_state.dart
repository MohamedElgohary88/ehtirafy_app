import 'package:equatable/equatable.dart';
import '../../domain/entities/freelancer_stats_entity.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/entities/portfolio_item_entity.dart';
import '../../domain/entities/freelancer_order_entity.dart';

abstract class FreelancerDashboardState extends Equatable {
  const FreelancerDashboardState();

  @override
  List<Object?> get props => [];
}

class FreelancerDashboardInitial extends FreelancerDashboardState {}

class FreelancerDashboardLoading extends FreelancerDashboardState {}

class FreelancerDashboardLoaded extends FreelancerDashboardState {
  final FreelancerStatsEntity stats;
  final List<PortfolioItemEntity> portfolioItems;
  final List<GigEntity> gigs;
  final List<FreelancerOrderEntity> recentOrders;
  final String userName;

  const FreelancerDashboardLoaded({
    required this.stats,
    required this.portfolioItems,
    required this.gigs,
    required this.recentOrders,
    this.userName = 'أحمد المصور',
  });

  @override
  List<Object?> get props => [
    stats,
    portfolioItems,
    gigs,
    recentOrders,
    userName,
  ];

  FreelancerDashboardLoaded copyWith({
    FreelancerStatsEntity? stats,
    List<PortfolioItemEntity>? portfolioItems,
    List<GigEntity>? gigs,
    List<FreelancerOrderEntity>? recentOrders,
    String? userName,
  }) {
    return FreelancerDashboardLoaded(
      stats: stats ?? this.stats,
      portfolioItems: portfolioItems ?? this.portfolioItems,
      gigs: gigs ?? this.gigs,
      recentOrders: recentOrders ?? this.recentOrders,
      userName: userName ?? this.userName,
    );
  }
}

class FreelancerDashboardError extends FreelancerDashboardState {
  final String message;

  const FreelancerDashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
