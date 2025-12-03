import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/features/booking/domain/entities/booking_request_entity.dart';
import 'package:ehtirafy_app/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  @override
  Future<Either<Failure, Map<String, dynamic>>> submitBookingRequest(
    BookingRequestEntity bookingRequest,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Return mock success response
      return Right(AppMockData.mockBookingSuccessResponse);
    } catch (e) {
      return Left(ServerFailure('Server Error'));
    }
  }
}
