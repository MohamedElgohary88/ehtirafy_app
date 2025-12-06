import 'package:equatable/equatable.dart';

enum GigStatus { active, pending, inactive }

class GigEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final GigStatus status;
  final String coverImage;
  final DateTime createdAt;

  const GigEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.status,
    required this.coverImage,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    category,
    status,
    coverImage,
    createdAt,
  ];
}
