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
    // API might return 'title' directly or 'ar_title', 'en_title'
    // Handle both formats for compatibility
    String parseTitle() {
      if (json['title'] != null) return json['title'].toString();
      return json['en_title']?.toString() ?? json['ar_title']?.toString() ?? '';
    }

    String parseDescription() {
      if (json['description'] != null) return json['description'].toString();
      return json['en_description']?.toString() ??
          json['ar_description']?.toString() ??
          '';
    }

    // Extract cover image from images array
    String parseCoverImage() {
      if (json['images'] != null &&
          json['images'] is List &&
          (json['images'] as List).isNotEmpty) {
        return json['images'][0].toString();
      }
      return '';
    }

    return GigModel(
      id: json['id']?.toString() ?? '',
      title: parseTitle(),
      description: parseDescription(),
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      category: json['category_id']?.toString() ?? '',
      status: _parseStatus(json['status']?.toString() ?? ''),
      coverImage: parseCoverImage(),
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
