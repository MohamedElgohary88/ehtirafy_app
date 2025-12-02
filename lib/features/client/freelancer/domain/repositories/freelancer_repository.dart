import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/client/freelancer/domain/entities/freelancer_entity.dart';

abstract class FreelancerRepository {
  Future<Either<Failure, FreelancerEntity>> getFreelancerProfile(String id);
}
