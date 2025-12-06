import '../../domain/entities/portfolio_item_entity.dart';

class PortfolioItemModel extends PortfolioItemEntity {
  const PortfolioItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.cameraType,
    required super.imageUrl,
    required super.category,
    required super.createdAt,
  });

  factory PortfolioItemModel.fromJson(Map<String, dynamic> json) {
    return PortfolioItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      cameraType: json['cameraType'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'cameraType': cameraType,
      'imageUrl': imageUrl,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
