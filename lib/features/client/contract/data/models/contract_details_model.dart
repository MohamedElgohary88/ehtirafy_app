import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_details_entity.dart';

class ContractDetailsModel extends ContractDetailsEntity {
  const ContractDetailsModel({
    required super.id,
    required super.status,
    required super.serviceTitle,
    required super.serviceCategory,
    required super.description,
    required super.location,
    required super.date,
    required super.budget,
    required super.isPaymentDeposited,
    required super.photographerName,
    required super.photographerImage,
    super.approvedAt,
    super.contractStatus,
    super.contrPubStatus,
    super.contrCustStatus,
  });

  factory ContractDetailsModel.fromJson(Map<String, dynamic> json) {
    return ContractDetailsModel(
      id: json['id']?.toString() ?? '',
      status: deriveStatus(json),
      serviceTitle: json['advertisement']?['title'] is Map
          ? (json['advertisement']?['title']['en'] ?? '')
          : (json['advertisement']?['title'] ?? ''),
      serviceCategory: json['advertisement']?['category_id']?.toString() ?? '',
      description: json['advertisement']?['description'] is Map
          ? (json['advertisement']?['description']['en'] ?? '')
          : (json['advertisement']?['description'] ?? ''),
      location: 'Saudi Arabia', // Mock or parse if available
      date: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      budget:
          double.tryParse(json['requested_amount']?.toString() ?? '0') ?? 0.0,
      isPaymentDeposited:
          false, // You might need to map this from API if available
      photographerName: json['publisher']?['name'] ?? '',
      photographerImage: json['publisher']?['image'] ?? '',
      approvedAt: json['approval_at'] != null
          ? DateTime.parse(json['approval_at'])
          : null,
      contractStatus: json['contract_status'],
      contrPubStatus: json['contr_pub_status'],
      contrCustStatus: json['contr_cust_status'],
    );
  }

  /// Helper to derive status from raw API fields
  static ContractStatus deriveStatus(Map<String, dynamic> json) {
    final contractStatus = json['contract_status']?.toString().toLowerCase();
    final pubStatus = json['contr_pub_status']?.toString().toLowerCase();
    final custStatus = json['contr_cust_status']?.toString().toLowerCase();

    if (pubStatus == 'rejected') return ContractStatus.cancelled; // or rejected
    if (custStatus == 'cancelled') return ContractStatus.cancelled;
    if (contractStatus == 'closed' ||
        pubStatus == 'completed' ||
        custStatus == 'completed') {
      return ContractStatus.completed;
    }

    if (pubStatus == 'approved') {
      if (custStatus == 'inprocess' ||
          custStatus == 'paid' ||
          custStatus == 'approved' ||
          custStatus == 'completed') {
        return ContractStatus.inProgress;
      }
      return ContractStatus.awaitingPayment;
    }

    return ContractStatus.underReview; // Default for initial / pending
  }
}
