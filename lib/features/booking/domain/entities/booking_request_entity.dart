import 'package:equatable/equatable.dart';

class BookingRequestEntity extends Equatable {
  final String serviceId;
  final String freelancerId;
  final String date;
  final String time;
  final String location;
  final String notes;

  const BookingRequestEntity({
    required this.serviceId,
    required this.freelancerId,
    required this.date,
    required this.time,
    required this.location,
    required this.notes,
  });

  @override
  List<Object?> get props => [
    serviceId,
    freelancerId,
    date,
    time,
    location,
    notes,
  ];
}
