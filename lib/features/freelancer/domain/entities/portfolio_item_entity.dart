import 'package:equatable/equatable.dart';

class PortfolioItemEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String cameraType;
  final String imageUrl;
  final String category;
  final DateTime createdAt;

  const PortfolioItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.cameraType,
    required this.imageUrl,
    required this.category,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    cameraType,
    imageUrl,
    category,
    createdAt,
  ];
}
