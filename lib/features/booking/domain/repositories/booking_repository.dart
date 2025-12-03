import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/features/booking/domain/entities/booking_request_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure, Map<String, dynamic>>> submitBookingRequest(
    BookingRequestEntity bookingRequest,
  );
}
