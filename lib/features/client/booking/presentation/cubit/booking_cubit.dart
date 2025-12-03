import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/submit_booking_request_usecase.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final SubmitBookingRequestUseCase submitBookingRequestUseCase;

  BookingCubit(this.submitBookingRequestUseCase) : super(BookingInitial());

  Future<void> submitBooking({
    required String freelancerId,
    required String serviceName,
    required double price,
    required String date,
    required String time,
    required String notes,
  }) async {
    emit(BookingLoading());
    final result = await submitBookingRequestUseCase(
      freelancerId: freelancerId,
      serviceName: serviceName,
      price: price,
      date: date,
      time: time,
      notes: notes,
    );

    result.fold(
      (failure) => emit(BookingError(failure.message)),
      (success) => emit(BookingSuccess()),
    );
  }
}
