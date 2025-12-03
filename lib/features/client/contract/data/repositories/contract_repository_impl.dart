import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/features/client/contract/data/models/contract_details_model.dart';
import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_details_entity.dart';
import 'package:ehtirafy_app/features/client/contract/domain/repositories/contract_repository.dart';

class ContractRepositoryImpl implements ContractRepository {
  @override
  Future<Either<Failure, ContractDetailsEntity>> getContractDetails(
    String id,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      final data = AppMockData.getContractDetails(id);
      final model = ContractDetailsModel.fromJson(data);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
