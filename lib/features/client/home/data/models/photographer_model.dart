import 'package:ehtirafy_app/features/client/home/domain/entities/photographer_entity.dart';

class PhotographerModel extends PhotographerEntity {
  const PhotographerModel({
    required super.id,
    required super.name,
    required super.category,
    required super.rating,
    required super.reviewsCount,
    required super.location,
    required super.price,
    required super.imageUrl,
  });

  factory PhotographerModel.fromJson(Map<String, dynamic> json) {
    return PhotographerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'] as int,
      location: json['location'] as String,
      price: json['price'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'location': location,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
