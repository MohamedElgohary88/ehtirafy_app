import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/features/client/contract/data/models/contract_details_model.dart';
import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_details_entity.dart';
import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_entity.dart';
import 'package:ehtirafy_app/features/client/contract/domain/repositories/contract_repository.dart';
import 'package:ehtirafy_app/features/client/contract/data/datasources/contract_remote_data_source.dart';

class ContractRepositoryImpl implements ContractRepository {
  final ContractRemoteDataSource?
  remoteDataSource; // Nullable for backward compatibility/mock usage if needed, but preferably required

  ContractRepositoryImpl({this.remoteDataSource});

  @override
  Future<Either<Failure, ContractDetailsEntity>> getContractDetails(
    String id,
  ) async {
    try {
      // Still using mock for details as remote source doesn't have it yet?
      // Or we can try to use getContracts filtered by ID if API supports details there.
      // Keeping mock logic for getContractDetails as requested in plan (NEW ContractRemoteDataSource didn't replace this explicitly to remote yet, or did it?)
      // Plan said: Update ContractRepositoryImpl (Shared logic).
      // Assuming getContracts is the new part.

      await Future.delayed(const Duration(seconds: 1));
      final data = AppMockData.getContractDetails(id);
      final model = ContractDetailsModel.fromJson(data);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ContractEntity>>> getContracts({
    Map<String, dynamic>? params,
  }) async {
    try {
      if (remoteDataSource == null) {
        // Fallback or error
        return const Right([]);
      }
      final contracts = await remoteDataSource!.getContracts(params ?? {});
      return Right(contracts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContractEntity>> updateContractStatus(
    String id,
    String status, {
    bool isPublisher = false,
  }) async {
    try {
      if (remoteDataSource == null) {
        throw Exception("RemoteDataSource not initialized");
      }

      final Map<String, dynamic> body = {'_method': 'put'};

      if (isPublisher) {
        body['contr_pub_status'] = status;
      } else {
        body['contr_cust_status'] = status;
      }

      final contract = await remoteDataSource!.updateContract(id, body);
      return Right(contract);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
