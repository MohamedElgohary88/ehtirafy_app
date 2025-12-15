import 'package:ehtirafy_app/features/client/freelancer/domain/entities/freelancer_entity.dart';
import 'package:ehtirafy_app/features/client/freelancer/data/models/service_model.dart';
import 'package:ehtirafy_app/features/client/freelancer/data/models/review_model.dart';

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
    required List<PortfolioItemModel> super.portfolio,
    List<ServiceModel> super.services = const [],
    List<ReviewModel> super.reviews = const [],
  });

  factory FreelancerModel.fromJson(Map<String, dynamic> json) {
    var rawPortfolio = json['our_works'] ?? json['portfolio'];
    var rawServices = json['advertisements'] ?? json['services'];
    var rawReviews = json['reviews'];

    return FreelancerModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? json['job_title'] ?? '',
      location: json['location'] ?? '',
      bio: json['bio'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviews_count'] ?? json['reviewsCount'] ?? 0,
      projectsCount: json['projects_count'] ?? json['projectsCount'] ?? 0,
      responseTime: json['response_time'] ?? json['responseTime'] ?? '',
      memberSince: json['created_at'] ?? json['memberSince'] ?? '',
      imageUrl: json['avatar'] ?? json['imageUrl'] ?? '',
      portfolio: rawPortfolio != null
          ? (rawPortfolio as List)
                .map((e) => PortfolioItemModel.fromJson(e))
                .toList()
          : [],
      services: rawServices != null
          ? (rawServices as List).map((e) => ServiceModel.fromJson(e)).toList()
          : [],
      reviews: rawReviews != null
          ? (rawReviews as List).map((e) => ReviewModel.fromJson(e)).toList()
          : [],
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
      'reviews_count': reviewsCount,
      'projects_count': projectsCount,
      'response_time': responseTime,
      'created_at': memberSince,
      'avatar': imageUrl,
      'our_works': portfolio
          .map((e) => (e as PortfolioItemModel).toJson())
          .toList(),
      'advertisements': services
          .map((e) => (e as ServiceModel).toJson())
          .toList(),
      'reviews': reviews.map((e) => (e as ReviewModel).toJson()).toList(),
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
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image'] ?? json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'category': category, 'image': imageUrl};
  }
}
