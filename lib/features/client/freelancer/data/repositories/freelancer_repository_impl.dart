import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/client/freelancer/data/datasources/freelancer_remote_data_source.dart';
import 'package:ehtirafy_app/features/client/freelancer/domain/entities/freelancer_entity.dart';
import 'package:ehtirafy_app/features/client/freelancer/domain/repositories/freelancer_repository.dart';

class FreelancerRepositoryImpl implements FreelancerRepository {
  final FreelancerRemoteDataSource remoteDataSource;

  FreelancerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FreelancerEntity>> getFreelancerProfile(
    String id,
  ) async {
    try {
      final remoteFreelancer = await remoteDataSource.getFreelancerProfile(id);
      return Right(remoteFreelancer);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
