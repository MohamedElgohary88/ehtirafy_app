import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehtirafy_app/features/booking/domain/entities/booking_request_entity.dart';
import 'package:ehtirafy_app/features/booking/domain/usecases/submit_booking_request_usecase.dart';
import 'package:ehtirafy_app/features/booking/presentation/cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final SubmitBookingRequestUseCase submitBookingRequestUseCase;

  BookingCubit({required this.submitBookingRequestUseCase})
    : super(BookingInitial());

  Future<void> submitBooking(BookingRequestEntity bookingRequest) async {
    emit(BookingLoading());

    final result = await submitBookingRequestUseCase(bookingRequest);

    result.fold(
      (failure) => emit(const BookingError('حدث خطأ أثناء إرسال الطلب')),
      (response) => emit(BookingSuccess(response)),
    );
  }
}
