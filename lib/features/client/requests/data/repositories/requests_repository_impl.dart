import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import '../../domain/entities/request_entity.dart';
import '../../domain/repositories/requests_repository.dart';
import '../models/request_model.dart';

class RequestsRepositoryImpl implements RequestsRepository {
  @override
  Future<Either<Failure, List<RequestEntity>>> getMyRequests() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Use mock data
      final requests = AppMockData.mockMyRequests;

      return Right(requests.map((e) => RequestModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
