import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/features/client/contract/data/datasources/contract_remote_data_source.dart';
import 'package:ehtirafy_app/features/freelancer/domain/entities/freelancer_order_entity.dart';
import 'package:ehtirafy_app/features/freelancer/domain/repositories/freelancer_orders_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreelancerOrdersRepositoryImpl implements FreelancerOrdersRepository {
  final ContractRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  FreelancerOrdersRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, List<FreelancerOrderEntity>>> getOrders() async {
    try {
      // If no user ID, maybe return empty or error.
      // Assuming 'contracts-reltive' endpoint might filter by logged in user automatically (contracts relative to user).
      // Or we pass publisher_id.
      // Based on endpoint name 'contracts-reltive', it likely returns contracts relative to the authenticated user.

      final contracts = await remoteDataSource.getContracts({});

      // Map ContractModel to FreelancerOrderEntity
      // FreelancerOrderEntity likely needs updates to match Contract fields if they differ significantly.
      // For now, mapping what we can.

      final orders = contracts.map((c) {
        FreelancerOrderStatus status;
        switch (c.contrPubStatus?.toLowerCase()) {
          case 'accepted':
          case 'inprogress':
            status = FreelancerOrderStatus.inProgress;
            break;
          case 'completed':
            status = FreelancerOrderStatus.completed;
            break;
          case 'rejected':
          case 'cancelled':
            status = FreelancerOrderStatus.cancelled;
            break;
          default:
            status = FreelancerOrderStatus.pending;
        }

        return FreelancerOrderEntity(
          id: c.id.toString(),
          clientName: c.clientName ?? 'Unknown Client',
          serviceTitle: c.serviceTitle ?? 'Requested Service',
          status: status,
          price: double.tryParse(c.requestedAmount) ?? 0.0,
          location: 'Remote', // Placeholder as location isn't in contract yet
          eventDate: c.createdAt, // Using createdAt as event date for now
          createdAt: c.createdAt,
          clientImage: c.clientImage ?? '',
        );
      }).toList();

      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FreelancerOrderEntity>> acceptOrder(
    String orderId,
  ) async {
    try {
      final contract = await remoteDataSource.updateContract(orderId, {
        'contr_pub_status': 'accepted',
        '_method': 'put',
      });

      // Assume updated status is accepted/inProgress
      return Right(
        FreelancerOrderEntity(
          id: contract.id.toString(),
          clientName: contract.clientName ?? 'Unknown Client',
          serviceTitle: contract.serviceTitle ?? 'Requested Service',
          status: FreelancerOrderStatus.inProgress,
          price: double.tryParse(contract.requestedAmount) ?? 0.0,
          location: 'Remote',
          eventDate: contract.createdAt,
          createdAt: contract.createdAt,
          clientImage: contract.clientImage ?? '',
        ),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rejectOrder(String orderId) async {
    try {
      await remoteDataSource.updateContract(orderId, {
        'contr_pub_status': 'rejected',
        '_method': 'put',
      });
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FreelancerOrderEntity>> getOrderDetails(
    String orderId,
  ) async {
    try {
      final contracts = await remoteDataSource.getContracts({'id': orderId});
      if (contracts.isNotEmpty) {
        final c = contracts.first;

        FreelancerOrderStatus status;
        switch (c.contrPubStatus?.toLowerCase()) {
          case 'accepted':
          case 'inprogress':
            status = FreelancerOrderStatus.inProgress;
            break;
          case 'completed':
            status = FreelancerOrderStatus.completed;
            break;
          case 'rejected':
          case 'cancelled':
            status = FreelancerOrderStatus.cancelled;
            break;
          default:
            status = FreelancerOrderStatus.pending;
        }

        return Right(
          FreelancerOrderEntity(
            id: c.id.toString(),
            clientName: c.clientName ?? 'Unknown Client',
            serviceTitle: c.serviceTitle ?? 'Requested Service',
            status: status,
            price: double.tryParse(c.requestedAmount) ?? 0.0,
            location: 'Remote',
            eventDate: c.createdAt,
            createdAt: c.createdAt,
            clientImage: c.clientImage ?? '',
          ),
        );
      }
      return const Left(ServerFailure('Order not found'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
