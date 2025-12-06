import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import '../entities/portfolio_item_entity.dart';

abstract class FreelancerPortfolioRepository {
  /// Get all portfolio items
  Future<Either<Failure, List<PortfolioItemEntity>>> getPortfolioItems();

  /// Add a new portfolio item
  Future<Either<Failure, PortfolioItemEntity>> addPortfolioItem({
    required String title,
    required String description,
    required String cameraType,
    required String imageUrl,
    required String category,
  });

  /// Delete a portfolio item
  Future<Either<Failure, void>> deletePortfolioItem(String itemId);
}
