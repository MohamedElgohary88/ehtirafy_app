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
  });

  factory ContractDetailsModel.fromJson(Map<String, dynamic> json) {
    return ContractDetailsModel(
      id: json['id'],
      status: ContractStatus.values.firstWhere(
        (e) => e.toString() == 'ContractStatus.${json['status']}',
        orElse: () => ContractStatus.inProgress,
      ),
      serviceTitle: json['serviceTitle'],
      serviceCategory: json['serviceCategory'],
      description: json['description'],
      location: json['location'],
      date: DateTime.parse(json['date']),
      budget: (json['budget'] as num).toDouble(),
      isPaymentDeposited: json['isPaymentDeposited'],
      photographerName: json['photographerName'],
      photographerImage: json['photographerImage'],
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'])
          : null,
    );
  }
}
