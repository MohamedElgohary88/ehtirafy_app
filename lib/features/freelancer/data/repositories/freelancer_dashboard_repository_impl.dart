import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/features/shared/auth/data/datasources/user_local_data_source.dart';
import 'package:ehtirafy_app/features/freelancer/data/datasources/freelancer_gigs_remote_data_source.dart';
import '../../domain/entities/freelancer_stats_entity.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/entities/portfolio_item_entity.dart';
import '../../domain/entities/freelancer_order_entity.dart';
import '../../domain/repositories/freelancer_dashboard_repository.dart';
import '../models/freelancer_stats_model.dart';
import '../models/portfolio_item_model.dart';
import '../models/freelancer_order_model.dart';

class FreelancerDashboardRepositoryImpl
    implements FreelancerDashboardRepository {
  final UserLocalDataSource userLocalDataSource;
  final FreelancerGigsRemoteDataSource gigsRemoteDataSource;

  bool _isOnline = true;

  FreelancerDashboardRepositoryImpl({
    required this.userLocalDataSource,
    required this.gigsRemoteDataSource,
  });

  @override
  Future<Either<Failure, FreelancerStatsEntity>> getStats() async {
    try {
      // Get user data from local storage
      final user = await userLocalDataSource.getUser();
      // We can use user.name here if needed, but getStats usually returns stats logic.
      // But we can expose user name via a separate method or within stats if stats entity supports it.
      // The DashboardCubit expects userName separately? checking state...
      // FreelancerDashboardLoaded has userName.
      // The Cubit gets userName directly from somewhere?
      // Cubit calls `getStats`, `getPortfolioPreview`, etc.
      // It doesn't seem to have `getUserName` method in Repository interface.
      // I should add `getUserName` to repository interface and implementation.

      // Simulate network delay for stats
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
      // Use real API
      final gigs = await gigsRemoteDataSource.getGigs();
      // Take top 3 for preview logic
      final List<GigEntity> previewGigs = gigs.take(3).toList();
      return Right(previewGigs);
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

  @override
  Future<String> getUserName() async {
    try {
      final user = await userLocalDataSource.getUser();
      return user?.name ?? 'مستخدم';
    } catch (_) {
      return 'مستخدم';
    }
  }
}
