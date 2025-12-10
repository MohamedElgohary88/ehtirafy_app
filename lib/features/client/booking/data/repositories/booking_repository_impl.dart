import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/features/client/booking/domain/repositories/booking_repository.dart';
import 'package:ehtirafy_app/features/client/contract/data/datasources/contract_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingRepositoryImpl implements BookingRepository {
  final ContractRemoteDataSource remoteDataSource;
  final SharedPreferences
  sharedPreferences; // To get current user ID if not passed

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences, // Assuming we might need this or pass user ID from caller
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> submitBookingRequest({
    required String freelancerId,
    required String serviceName,
    required double price,
    required String date,
    required String time,
    required String notes,
  }) async {
    try {
      // Need current user ID (customer_id) and maybe advertisement_id
      // The interface only has serviceName, price etc.
      // Assuming 'serviceName' might carry ID or we need to update the interface to pass advertisementId.
      // For now, mapping best effort.

      final customerId =
          sharedPreferences.getString('user_id') ?? ''; // Or handle error

      final body = {
        'advertisement_id':
            '1', // Placeholder: Interface update required to pass real ID
        'publisher_id': freelancerId,
        'customer_id': customerId,
        'requested_amount': price.toString(),
        'actual_amount': price.toString(),
        // Add dates/notes if API supports extra fields in initial-contract or if it's strictly the defined body
      };

      final contract = await remoteDataSource.createInitialContract(body);

      return Right(contract.toJson());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
