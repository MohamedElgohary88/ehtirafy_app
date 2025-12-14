import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/features/shared/auth/data/datasources/user_local_data_source.dart';
import 'package:ehtirafy_app/features/freelancer/data/datasources/freelancer_gigs_remote_data_source.dart';
import 'package:ehtirafy_app/features/freelancer/data/datasources/freelancer_portfolio_remote_data_source.dart';
import '../../domain/entities/freelancer_stats_entity.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/entities/portfolio_item_entity.dart';
import '../../domain/entities/freelancer_order_entity.dart';
import '../../domain/repositories/freelancer_dashboard_repository.dart';
import '../models/freelancer_stats_model.dart';
import '../models/freelancer_order_model.dart';

/// Dashboard repository implementation with real API data for gigs and portfolio
class FreelancerDashboardRepositoryImpl
    implements FreelancerDashboardRepository {
  final UserLocalDataSource userLocalDataSource;
  final FreelancerGigsRemoteDataSource gigsRemoteDataSource;
  final FreelancerPortfolioRemoteDataSource? portfolioRemoteDataSource;

  bool _isOnline = true;

  FreelancerDashboardRepositoryImpl({
    required this.userLocalDataSource,
    required this.gigsRemoteDataSource,
    this.portfolioRemoteDataSource,
  });

  @override
  Future<Either<Failure, FreelancerStatsEntity>> getStats() async {
    try {
      // Simulate network delay for stats (still mock for now)
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
      // Use real API if available
      if (portfolioRemoteDataSource != null) {
        final portfolioItems = await portfolioRemoteDataSource!.getPortfolio();
        // Take top 4 for preview
        final previewItems = portfolioItems.take(4).toList();
        return Right(previewItems);
      }

      // Fallback to empty list if no remote source
      return const Right([]);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('فشل في جلب معرض الأعمال'));
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
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('فشل في جلب الخدمات'));
    }
  }

  @override
  Future<Either<Failure, List<FreelancerOrderEntity>>> getRecentOrders() async {
    try {
      // Still using mock for orders (needs API endpoint)
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
