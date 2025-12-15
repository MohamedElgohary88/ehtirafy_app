import 'package:ehtirafy_app/core/network/dio_client.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/features/shared/reviews/data/models/review_model.dart';

abstract class ReviewsRemoteDataSource {
  Future<void> addRate({
    required String ratedUserId,
    required double rating,
    required String comment,
  });

  Future<List<ReviewModel>> getUserRates({required String userId});
}

class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  final DioClient dioClient;

  ReviewsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<void> addRate({
    required String ratedUserId,
    required double rating,
    required String comment,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/v1/front/add-rate',
        data: {
          'rateable_id': ratedUserId,
          'rateable_type': 'user', // Assuming 'user' is the type
          'rate': rating,
          'comment': comment,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ReviewModel>> getUserRates({required String userId}) async {
    try {
      final response = await dioClient.get(
        '/api/v1/front/user-rates',
        queryParameters: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => ReviewModel.fromJson(e))
            .toList();
      } else {
        throw ServerException(response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
