import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_entity.dart';

class ContractModel extends ContractEntity {
  const ContractModel({
    required super.id,
    required super.advertisementId,
    required super.publisherId,
    required super.customerId,
    required super.requestedAmount,
    required super.actualAmount,
    super.contrPubStatus,
    super.contrCustStatus,
    required super.createdAt,
    required super.updatedAt,
    super.serviceTitle,
    super.clientName,
    super.clientImage,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      advertisementId: json['advertisement_id']?.toString() ?? '',
      publisherId: json['publisher_id']?.toString() ?? '',
      customerId: json['customer_id']?.toString() ?? '',
      requestedAmount: json['requested_amount']?.toString() ?? '0',
      actualAmount: json['actual_amount']?.toString() ?? '0',
      contrPubStatus: json['contr_pub_status'],
      contrCustStatus: json['contr_cust_status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      // Mappings below depend on actual API response for lists, placeholders for now
      serviceTitle: json['advertisement']?['title'] ?? '',
      clientName: json['customer']?['name'] ?? '',
      clientImage: json['customer']?['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'advertisement_id': advertisementId,
      'publisher_id': publisherId,
      'customer_id': customerId,
      'requested_amount': requestedAmount,
      'actual_amount': actualAmount,
      'contr_pub_status': contrPubStatus,
      'contr_cust_status': contrCustStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
