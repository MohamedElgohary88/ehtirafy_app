import 'package:equatable/equatable.dart';

class FreelancerEntity extends Equatable {
  final String id;
  final String name;
  final String title;
  final String location;
  final String bio;
  final double rating;
  final int reviewsCount;
  final int projectsCount;
  final String responseTime;
  final String memberSince;
  final String imageUrl;
  final List<PortfolioItemEntity> portfolio;

  const FreelancerEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.location,
    required this.bio,
    required this.rating,
    required this.reviewsCount,
    required this.projectsCount,
    required this.responseTime,
    required this.memberSince,
    required this.imageUrl,
    required this.portfolio,
  });

  @override
  List<Object> get props => [
    id,
    name,
    title,
    location,
    bio,
    rating,
    reviewsCount,
    projectsCount,
    responseTime,
    memberSince,
    imageUrl,
    portfolio,
  ];
}

class PortfolioItemEntity extends Equatable {
  final String id;
  final String title;
  final String category;
  final String imageUrl;

  const PortfolioItemEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, title, category, imageUrl];
}
