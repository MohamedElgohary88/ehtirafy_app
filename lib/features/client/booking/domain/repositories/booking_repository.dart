import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';

abstract class BookingRepository {
  Future<Either<Failure, Map<String, dynamic>>> submitBookingRequest({
    required String freelancerId,
    required String serviceName,
    required double price,
    required String date,
    required String time,
    required String notes,
  });
}
