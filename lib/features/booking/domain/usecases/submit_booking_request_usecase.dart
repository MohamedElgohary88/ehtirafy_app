import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/features/booking/domain/entities/booking_request_entity.dart';
import 'package:ehtirafy_app/features/booking/domain/repositories/booking_repository.dart';

class SubmitBookingRequestUseCase {
  final BookingRepository repository;

  SubmitBookingRequestUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(
    BookingRequestEntity bookingRequest,
  ) async {
    return await repository.submitBookingRequest(bookingRequest);
  }
}
