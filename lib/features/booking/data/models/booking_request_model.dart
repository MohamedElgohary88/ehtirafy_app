import 'package:ehtirafy_app/features/booking/domain/entities/booking_request_entity.dart';

class BookingRequestModel extends BookingRequestEntity {
  const BookingRequestModel({
    required super.serviceId,
    required super.freelancerId,
    required super.date,
    required super.time,
    required super.location,
    required super.notes,
  });

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) {
    return BookingRequestModel(
      serviceId: json['serviceId'],
      freelancerId: json['freelancerId'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'freelancerId': freelancerId,
      'date': date,
      'time': time,
      'location': location,
      'notes': notes,
    };
  }
}
