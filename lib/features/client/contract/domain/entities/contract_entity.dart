import 'package:equatable/equatable.dart';

class ContractEntity extends Equatable {
  final int id;
  final String advertisementId;
  final String publisherId;
  final String customerId;
  final String requestedAmount;
  final String actualAmount;
  final String? contrPubStatus;
  final String? contrCustStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Additional fields for display in lists (will need to verify if API returns them in list view)
  final String? serviceTitle;
  final String? clientName;
  final String? clientImage;

  const ContractEntity({
    required this.id,
    required this.advertisementId,
    required this.publisherId,
    required this.customerId,
    required this.requestedAmount,
    required this.actualAmount,
    this.contrPubStatus,
    this.contrCustStatus,
    required this.createdAt,
    required this.updatedAt,
    this.serviceTitle,
    this.clientName,
    this.clientImage,
  });

  @override
  List<Object?> get props => [
    id,
    advertisementId,
    publisherId,
    customerId,
    requestedAmount,
    actualAmount,
    contrPubStatus,
    contrCustStatus,
    createdAt,
    updatedAt,
    serviceTitle,
    clientName,
    clientImage,
  ];
}
