import 'package:equatable/equatable.dart';

enum FreelancerOrderStatus { pending, inProgress, completed, cancelled }

class FreelancerOrderEntity extends Equatable {
  final String id;
  final String serviceTitle;
  final String clientName;
  final String clientImage;
  final FreelancerOrderStatus status;
  final double price;
  final String location;
  final DateTime eventDate;
  final DateTime createdAt;

  const FreelancerOrderEntity({
    required this.id,
    required this.serviceTitle,
    required this.clientName,
    required this.clientImage,
    required this.status,
    required this.price,
    required this.location,
    required this.eventDate,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    serviceTitle,
    clientName,
    clientImage,
    status,
    price,
    location,
    eventDate,
    createdAt,
  ];
}
