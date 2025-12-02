import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/client/home/domain/entities/photographer_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<PhotographerEntity>>> getFeaturedPhotographers();
}
