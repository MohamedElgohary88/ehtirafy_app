import '../../domain/entities/app_statistics.dart';

class AppStatisticsModel extends AppStatistics {
  const AppStatisticsModel({
    required super.usersCount,
    required super.servicesCount,
    required super.contractsCount,
    required super.completedContracts,
    required super.totalEarnings,
    required super.worksCount,
    required super.ratingsCount,
    required super.ratingAvg,
  });

  factory AppStatisticsModel.fromJson(Map<String, dynamic> json) {
    return AppStatisticsModel(
      usersCount: json['users_count'] ?? 0,
      servicesCount: json['services_count'] ?? 0,
      contractsCount: json['contracts_count'] ?? 0,
      completedContracts: json['completed_contracts'] ?? 0,
      totalEarnings: json['total_earnings'] ?? 0,
      worksCount: json['works_count'] ?? 0,
      ratingsCount: json['ratings_count'] ?? 0,
      ratingAvg: json['rating_avg'] ?? 0,
    );
  }
}
