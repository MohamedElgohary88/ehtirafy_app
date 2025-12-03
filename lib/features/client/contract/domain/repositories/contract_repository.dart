import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_details_entity.dart';

abstract class ContractRepository {
  Future<Either<Failure, ContractDetailsEntity>> getContractDetails(String id);
}
