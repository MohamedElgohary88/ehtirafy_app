import '../../domain/entities/gig_entity.dart';

class GigModel extends GigEntity {
  const GigModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.category,
    required super.status,
    required super.coverImage,
    required super.createdAt,
  });

  factory GigModel.fromJson(Map<String, dynamic> json) {
    return GigModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      status: _parseStatus(json['status'] as String),
      coverImage: json['coverImage'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'status': _statusToString(status),
      'coverImage': coverImage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static GigStatus _parseStatus(String status) {
    switch (status) {
      case 'active':
        return GigStatus.active;
      case 'pending':
        return GigStatus.pending;
      case 'inactive':
        return GigStatus.inactive;
      default:
        return GigStatus.pending;
    }
  }

  static String _statusToString(GigStatus status) {
    switch (status) {
      case GigStatus.active:
        return 'active';
      case GigStatus.pending:
        return 'pending';
      case GigStatus.inactive:
        return 'inactive';
    }
  }
}
