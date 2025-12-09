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
    super.createdAt,
    super.availability,
    super.images,
  });

  factory GigModel.fromJson(Map<String, dynamic> json) {
    // API might return 'ar_title', 'en_title'. We pick 'en_title' or current locale.
    // For now assuming we prefer 'en' or combine them.
    // Actually, let's check what the API returns. The prompt says "Advertisements retrieved successfully".
    // It doesn't specify the exact READ fields, but likely matching the create params: ar_title, en_title.
    // Let's use 'en_title' as title for now.

    return GigModel(
      id: json['id']?.toString() ?? '',
      title: json['en_title'] ?? json['ar_title'] ?? '',
      description: json['en_description'] ?? json['ar_description'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      category: json['category_id']?.toString() ?? '', // category_id from API
      status: _parseStatus(json['status']?.toString() ?? ''),
      coverImage:
          (json['images'] != null && (json['images'] as List).isNotEmpty)
          ? json['images'][0]
          : '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      availability: json['days_availability'] != null
          ? List<String>.from(json['days_availability'])
          : [],
      images: json['images'] != null ? List<String>.from(json['images']) : [],
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
      'createdAt': createdAt?.toIso8601String(),
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
