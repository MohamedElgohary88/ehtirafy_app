import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/core/network/api_constants.dart';
import 'package:ehtirafy_app/core/network/dio_client.dart';
import 'package:ehtirafy_app/features/client/home/data/models/photographer_model.dart';
import 'package:ehtirafy_app/features/client/home/data/models/category_model.dart';
import 'package:ehtirafy_app/features/client/home/data/models/app_statistics_model.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';

abstract class HomeRemoteDataSource {
  Future<List<PhotographerModel>> getFeaturedPhotographers();
  Future<List<CategoryModel>> getCategories();
  Future<AppStatisticsModel> getAppStatistics();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<PhotographerModel>> getFeaturedPhotographers() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return AppMockData.photographers
        .map((e) => PhotographerModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dioClient.get(ApiConstants.categories);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['data'] != null && data['data'] is List) {
          return (data['data'] as List)
              .map((json) => CategoryModel.fromJson(json))
              .toList();
        }
      }
      return [];
    } catch (e) {
      // Return empty list on error, or rethrow if you want to handle it in repository
      rethrow;
    }
  }

  @override
  Future<AppStatisticsModel> getAppStatistics() async {
    try {
      final response = await dioClient.get('/api/v1/app/statistics');
      if (response.statusCode == 200) {
        return AppStatisticsModel.fromJson(response.data['data']);
      } else {
        throw ServerException(response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
