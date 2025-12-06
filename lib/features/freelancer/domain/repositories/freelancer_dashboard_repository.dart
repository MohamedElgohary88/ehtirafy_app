import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import '../entities/freelancer_stats_entity.dart';
import '../entities/gig_entity.dart';
import '../entities/portfolio_item_entity.dart';
import '../entities/freelancer_order_entity.dart';

abstract class FreelancerDashboardRepository {
  /// Get freelancer dashboard statistics
  Future<Either<Failure, FreelancerStatsEntity>> getStats();

  /// Get portfolio items for dashboard preview
  Future<Either<Failure, List<PortfolioItemEntity>>> getPortfolioPreview();

  /// Get gigs for dashboard preview
  Future<Either<Failure, List<GigEntity>>> getGigsPreview();

  /// Get recent orders for dashboard
  Future<Either<Failure, List<FreelancerOrderEntity>>> getRecentOrders();

  /// Toggle online/offline status
  Future<Either<Failure, bool>> toggleOnlineStatus(bool isOnline);
}
