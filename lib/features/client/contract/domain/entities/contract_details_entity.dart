import 'package:equatable/equatable.dart';

enum ContractStatus {
  inProgress,
  awaitingPayment,
  underReview,
  archived,
  completed,
  cancelled,
}

class ContractDetailsEntity extends Equatable {
  final String id;
  final ContractStatus status;
  final String serviceTitle;
  final String serviceCategory;
  final String description;
  final String location;
  final DateTime date;
  final double budget;
  final bool isPaymentDeposited;
  final String photographerName;
  final String photographerImage;
  final DateTime? approvedAt; // For AwaitingPayment timer

  const ContractDetailsEntity({
    required this.id,
    required this.status,
    required this.serviceTitle,
    required this.serviceCategory,
    required this.description,
    required this.location,
    required this.date,
    required this.budget,
    required this.isPaymentDeposited,
    required this.photographerName,
    required this.photographerImage,
    this.approvedAt,
  });

  @override
  List<Object?> get props => [
    id,
    status,
    serviceTitle,
    serviceCategory,
    description,
    location,
    date,
    budget,
    isPaymentDeposited,
    photographerName,
    photographerImage,
    approvedAt,
  ];
}
