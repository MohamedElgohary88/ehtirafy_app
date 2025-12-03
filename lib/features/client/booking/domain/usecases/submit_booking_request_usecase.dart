import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/booking_repository.dart';

class SubmitBookingRequestUseCase {
  final BookingRepository repository;

  SubmitBookingRequestUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call({
    required String freelancerId,
    required String serviceName,
    required double price,
    required String date,
    required String time,
    required String notes,
  }) async {
    return await repository.submitBookingRequest(
      freelancerId: freelancerId,
      serviceName: serviceName,
      price: price,
      date: date,
      time: time,
      notes: notes,
    );
  }
}
