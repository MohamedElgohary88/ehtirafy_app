import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import '../../domain/entities/portfolio_item_entity.dart';
import '../../domain/repositories/freelancer_portfolio_repository.dart';
import '../models/portfolio_item_model.dart';

class FreelancerPortfolioRepositoryImpl
    implements FreelancerPortfolioRepository {
  // Local cache for mock data operations
  final List<Map<String, dynamic>> _portfolioCache = List.from(
    AppMockData.mockFreelancerPortfolio,
  );

  @override
  Future<Either<Failure, List<PortfolioItemEntity>>> getPortfolioItems() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final items = _portfolioCache
          .map((json) => PortfolioItemModel.fromJson(json))
          .toList();
      return Right(items);
    } catch (e) {
      return const Left(ServerFailure('فشل في جلب معرض الأعمال'));
    }
  }

  @override
  Future<Either<Failure, PortfolioItemEntity>> addPortfolioItem({
    required String title,
    required String description,
    required String cameraType,
    required String imageUrl,
    required String category,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final newItem = {
        'id': 'portfolio-${DateTime.now().millisecondsSinceEpoch}',
        'title': title,
        'description': description,
        'cameraType': cameraType,
        'imageUrl': imageUrl,
        'category': category,
        'createdAt': DateTime.now().toIso8601String(),
      };

      _portfolioCache.insert(0, newItem);
      return Right(PortfolioItemModel.fromJson(newItem));
    } catch (e) {
      return const Left(ServerFailure('فشل في إضافة العمل'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePortfolioItem(String itemId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      _portfolioCache.removeWhere((item) => item['id'] == itemId);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('فشل في حذف العمل'));
    }
  }
}
