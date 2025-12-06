import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import '../../domain/entities/freelancer_stats_entity.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/entities/portfolio_item_entity.dart';
import '../../domain/entities/freelancer_order_entity.dart';
import '../../domain/repositories/freelancer_dashboard_repository.dart';
import '../models/freelancer_stats_model.dart';
import '../models/gig_model.dart';
import '../models/portfolio_item_model.dart';
import '../models/freelancer_order_model.dart';

class FreelancerDashboardRepositoryImpl
    implements FreelancerDashboardRepository {
  bool _isOnline = true;

  @override
  Future<Either<Failure, FreelancerStatsEntity>> getStats() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final statsJson = Map<String, dynamic>.from(
        AppMockData.mockFreelancerStats,
      );
      statsJson['isOnline'] = _isOnline;
      final stats = FreelancerStatsModel.fromJson(statsJson);
      return Right(stats);
    } catch (e) {
      return const Left(ServerFailure('فشل في جلب الإحصائيات'));
    }
  }

  @override
  Future<Either<Failure, List<PortfolioItemEntity>>>
  getPortfolioPreview() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final portfolioItems = AppMockData.mockFreelancerPortfolio
          .take(4)
          .map((json) => PortfolioItemModel.fromJson(json))
          .toList();
      return Right(portfolioItems);
    } catch (e) {
      return const Left(ServerFailure('فشل في جلب معرض الأعمال'));
    }
  }

  @override
  Future<Either<Failure, List<GigEntity>>> getGigsPreview() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final gigs = AppMockData.mockFreelancerGigs
          .where((g) => g['status'] == 'active')
          .take(3)
          .map((json) => GigModel.fromJson(json))
          .toList();
      return Right(gigs);
    } catch (e) {
      return const Left(ServerFailure('فشل في جلب الخدمات'));
    }
  }

  @override
  Future<Either<Failure, List<FreelancerOrderEntity>>> getRecentOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final orders = AppMockData.mockFreelancerOrders
          .where((o) => o['status'] == 'pending' || o['status'] == 'inProgress')
          .take(2)
          .map((json) => FreelancerOrderModel.fromJson(json))
          .toList();
      return Right(orders);
    } catch (e) {
      return const Left(ServerFailure('فشل في جلب الطلبات'));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleOnlineStatus(bool isOnline) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      _isOnline = isOnline;
      return Right(_isOnline);
    } catch (e) {
      return const Left(ServerFailure('فشل في تغيير الحالة'));
    }
  }
}
