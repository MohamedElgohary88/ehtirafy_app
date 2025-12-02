import 'package:ehtirafy_app/features/client/freelancer/domain/entities/freelancer_entity.dart';

class FreelancerModel extends FreelancerEntity {
  const FreelancerModel({
    required super.id,
    required super.name,
    required super.title,
    required super.location,
    required super.bio,
    required super.rating,
    required super.reviewsCount,
    required super.projectsCount,
    required super.responseTime,
    required super.memberSince,
    required super.imageUrl,
    required List<PortfolioItemModel> portfolio,
  }) : super(portfolio: portfolio);

  factory FreelancerModel.fromJson(Map<String, dynamic> json) {
    return FreelancerModel(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      location: json['location'],
      bio: json['bio'],
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'],
      projectsCount: json['projectsCount'],
      responseTime: json['responseTime'],
      memberSince: json['memberSince'],
      imageUrl: json['imageUrl'],
      portfolio: (json['portfolio'] as List)
          .map((e) => PortfolioItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'location': location,
      'bio': bio,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'projectsCount': projectsCount,
      'responseTime': responseTime,
      'memberSince': memberSince,
      'imageUrl': imageUrl,
      'portfolio': portfolio
          .map((e) => (e as PortfolioItemModel).toJson())
          .toList(),
    };
  }
}

class PortfolioItemModel extends PortfolioItemEntity {
  const PortfolioItemModel({
    required super.id,
    required super.title,
    required super.category,
    required super.imageUrl,
  });

  factory PortfolioItemModel.fromJson(Map<String, dynamic> json) {
    return PortfolioItemModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}
