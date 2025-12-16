import 'package:dio/dio.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/core/network/api_constants.dart';
import 'package:ehtirafy_app/core/network/dio_client.dart';
import 'package:ehtirafy_app/features/freelancer/data/models/portfolio_item_model.dart';

abstract class FreelancerPortfolioRemoteDataSource {
  Future<List<PortfolioItemModel>> getPortfolio();

  /// Get portfolio work details by ID
  Future<PortfolioItemModel> getPortfolioItemById(String id);

  Future<PortfolioItemModel> addPortfolioItem(Map<String, dynamic> data);
  Future<PortfolioItemModel> updatePortfolioItem(
    String id,
    Map<String, dynamic> data,
  );
  Future<void> deletePortfolioItem(String id);
}

class FreelancerPortfolioRemoteDataSourceImpl
    implements FreelancerPortfolioRemoteDataSource {
  final DioClient _dioClient;

  FreelancerPortfolioRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<PortfolioItemModel>> getPortfolio() async {
    final response = await _dioClient.get(ApiConstants.freelancerPortfolio);
    final data = response.data;

    // Manual parsing to avoid generic issues and handle flexibility
    if (data['status'] == 200) {
      final responseData = data['data'];
      if (responseData is List) {
        return responseData
            .map((e) => PortfolioItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } else {
      throw ServerException(data['message'] ?? 'Unknown Error');
    }
  }

  @override
  Future<PortfolioItemModel> getPortfolioItemById(String id) async {
    final response = await _dioClient.get(
      ApiConstants.portfolioItemDetails(id),
    );
    final data = response.data;

    if (data['status'] == 200) {
      final responseData = data['data'];
      if (responseData is Map<String, dynamic>) {
        return PortfolioItemModel.fromJson(responseData);
      }
      throw ServerException('Invalid response format');
    } else {
      throw ServerException(data['message'] ?? 'Unknown Error');
    }
  }

  @override
  Future<PortfolioItemModel> addPortfolioItem(Map<String, dynamic> data) async {
    dynamic requestData = data;
    if (data.containsKey('image') && data['image'] != null) {
      final imagePath = data['image'];
      data.remove('image'); // Remove raw path string
      requestData = FormData.fromMap({
        ...data,
        'image': await MultipartFile.fromFile(imagePath),
      });
    }

    final response = await _dioClient.post(
      ApiConstants.freelancerPortfolio,
      data: requestData,
    );
    final responseData = response.data;

    if (responseData['status'] == 200) {
      final innerData = responseData['data'];
      if (innerData is Map<String, dynamic>) {
        return PortfolioItemModel.fromJson(innerData);
      }
      // If standard success message string, we return a dummy or rely on refresh.
      // Returning a partial model to indicate success, but caller should refresh.
      return PortfolioItemModel(
        id: '',
        title: data['ar_title'] ?? data['en_title'] ?? '',
        description: data['ar_description'] ?? data['en_description'] ?? '',
        createdAt: DateTime.now(),
      );
    } else {
      throw ServerException(responseData['message'] ?? 'Failed to add item');
    }
  }

  @override
  Future<PortfolioItemModel> updatePortfolioItem(
    String id,
    Map<String, dynamic> data,
  ) async {
    // Spoofing PUT with POST and _method
    // data['_method'] = 'PUT'; // Caller should handle this or we do it here.
    // User said "body all the same attributes like create but add _method = put"
    // I'll ensure it's added here if not present, but safer to add.
    final Map<String, dynamic> requestDataMap = Map.from(data);
    requestDataMap['_method'] = 'PUT';

    dynamic requestData = requestDataMap;
    if (requestDataMap.containsKey('image') &&
        requestDataMap['image'] != null) {
      final imagePath = requestDataMap['image'];
      requestDataMap.remove('image'); // Remove raw path string
      requestData = FormData.fromMap({
        ...requestDataMap,
        'image': await MultipartFile.fromFile(imagePath),
      });
    }

    final response = await _dioClient.post(
      '${ApiConstants.freelancerPortfolio}/$id',
      data: requestData,
    );

    final responseData = response.data;
    if (responseData['status'] == 200) {
      final innerData = responseData['data'];
      if (innerData is Map<String, dynamic>) {
        return PortfolioItemModel.fromJson(innerData);
      }
      // Fallback
      return PortfolioItemModel(
        id: id,
        title: requestData['ar_title'] ?? '',
        description: requestData['ar_description'] ?? '',
        createdAt: DateTime.now(),
      );
    } else {
      throw ServerException(responseData['message'] ?? 'Failed to update item');
    }
  }

  @override
  Future<void> deletePortfolioItem(String id) async {
    await _dioClient.delete('${ApiConstants.freelancerPortfolio}/$id');
  }
}
