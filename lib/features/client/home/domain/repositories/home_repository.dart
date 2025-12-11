import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/client/home/domain/entities/photographer_entity.dart';
import 'package:ehtirafy_app/features/client/home/domain/entities/category_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<PhotographerEntity>>> getFeaturedPhotographers();
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
