import 'package:equatable/equatable.dart';

enum ContractStatus {
  inProgress,
  awaitingPayment,
  underReview,
  archived,
  completed,
  cancelled,
  rejected,
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
  final String? contractStatus;
  final String? contrPubStatus;
  final String? contrCustStatus;

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
    this.contractStatus,
    this.contrPubStatus,
    this.contrCustStatus,
  });

  /// Chat allowed only for active contracts (in progress, under review, completed)
  /// Chat is NOT allowed for: awaiting payment (not started yet), cancelled, archived
  bool get isChatAllowed {
    return status == ContractStatus.inProgress ||
        status == ContractStatus.underReview ||
        status == ContractStatus.completed;
  }

  ContractDetailsEntity copyWith({
    String? id,
    ContractStatus? status,
    String? serviceTitle,
    String? serviceCategory,
    String? description,
    String? location,
    DateTime? date,
    double? budget,
    bool? isPaymentDeposited,
    String? photographerName,
    String? photographerImage,
    DateTime? approvedAt,
    String? contractStatus,
    String? contrPubStatus,
    String? contrCustStatus,
  }) {
    return ContractDetailsEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      description: description ?? this.description,
      location: location ?? this.location,
      date: date ?? this.date,
      budget: budget ?? this.budget,
      isPaymentDeposited: isPaymentDeposited ?? this.isPaymentDeposited,
      photographerName: photographerName ?? this.photographerName,
      photographerImage: photographerImage ?? this.photographerImage,
      approvedAt: approvedAt ?? this.approvedAt,
      contractStatus: contractStatus ?? this.contractStatus,
      contrPubStatus: contrPubStatus ?? this.contrPubStatus,
      contrCustStatus: contrCustStatus ?? this.contrCustStatus,
    );
  }

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
    contractStatus,
    contrPubStatus,
    contrCustStatus,
  ];
}
