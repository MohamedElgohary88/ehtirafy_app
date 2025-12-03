import 'package:dartz/dartz.dart';
import '../../../../../core/constants/app_mock_data.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
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
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      return Right(AppMockData.mockBookingSuccessResponse);
    } catch (e) {
      return Left(ServerFailure('Failed to submit booking request'));
    }
  }
}
