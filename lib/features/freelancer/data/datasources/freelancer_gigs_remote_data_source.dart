import 'package:dio/dio.dart';
import 'package:ehtirafy_app/core/network/api_constants.dart';
import 'package:ehtirafy_app/core/network/dio_client.dart';
import 'package:ehtirafy_app/features/freelancer/data/models/gig_model.dart';
import 'package:ehtirafy_app/features/freelancer/domain/entities/gig_entity.dart';
import 'package:ehtirafy_app/core/network/base_response.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/features/client/home/data/models/category_model.dart';

abstract class FreelancerGigsRemoteDataSource {
  /// Get gigs with user_type parameter
  /// - user_type=freelancer → Freelancer (photographer) sees their own gigs
  /// - user_type=customer → Customer (client) sees all available ads
  Future<List<GigModel>> getGigs({String userType = 'freelancer'});

  /// Get advertisement/gig details by ID
  Future<GigModel> getGigById(String id);

  /// Get categories from API
  Future<List<CategoryModel>> getCategories();

  Future<GigModel> addGig(Map<String, dynamic> data);
  Future<GigModel> updateGig(String id, Map<String, dynamic> data);
  Future<void> deleteGig(String id);
}

class FreelancerGigsRemoteDataSourceImpl
    implements FreelancerGigsRemoteDataSource {
  final DioClient _dioClient;

  FreelancerGigsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<GigModel>> getGigs({String userType = 'freelancer'}) async {
    final response = await _dioClient.get(
      ApiConstants.advertisements,
      queryParameters: {'user_type': userType},
    );
    final baseResponse = BaseResponse<List<dynamic>>.fromJson(
      response.data,
      (data) => data as List<dynamic>,
    );
    if (baseResponse.status == 200) {
      return baseResponse.data!.map((e) => GigModel.fromJson(e)).toList();
    } else {
      throw ServerException(baseResponse.message);
    }
  }

  @override
  Future<GigModel> getGigById(String id) async {
    final response = await _dioClient.get(
      ApiConstants.advertisementDetails(id),
    );
    final baseResponse = BaseResponse<Map<String, dynamic>>.fromJson(
      response.data,
      (data) => data as Map<String, dynamic>,
    );
    if (baseResponse.status == 200) {
      return GigModel.fromJson(baseResponse.data!);
    } else {
      throw ServerException(baseResponse.message);
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dioClient.get(ApiConstants.categories);

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
      throw ServerException(e.toString());
    }
  }

  @override
  Future<GigModel> addGig(Map<String, dynamic> data) async {
    final Map<String, dynamic> formDataMap = {
      'ar_title': data['ar_title'] ?? '',
      'en_title': data['en_title'] ?? '',
      'ar_description': data['ar_description'] ?? '',
      'en_description': data['en_description'] ?? '',
      'category_id': data['category_id'] ?? '',
      'price': data['price'] ?? 0,
    };

    // Handle images - API expects indexed format: images[0], images[1], etc.
    if (data.containsKey('images') && data['images'] is List) {
      final List<String> imagePaths = List<String>.from(data['images']);
      for (int i = 0; i < imagePaths.length; i++) {
        formDataMap['images[$i]'] = await MultipartFile.fromFile(imagePaths[i]);
      }
    }

    // Handle days_availability - API expects indexed format: days_availability[0], days_availability[1], etc.
    if (data.containsKey('days_availability') &&
        data['days_availability'] is List) {
      final List<String> availability = List<String>.from(
        data['days_availability'],
      );
      for (int i = 0; i < availability.length; i++) {
        formDataMap['days_availability[$i]'] = availability[i];
      }
    }

    final formData = FormData.fromMap(formDataMap);

    final response = await _dioClient.post(
      ApiConstants.advertisements,
      data: formData,
    );

    // Response: { status: 200, message: "Success", data: "Advertisement created successfully" }
    // It returns string, not the object. So we might need to fetch it again or return a mock/partial model?
    // User request said response data is "Advertisement created successfully".
    // This is problematic for Clean Architecture (we need the created ID).
    // Assuming for now we just return a success indicator or empty model.
    // Or maybe we can't return the full model.
    // I will throw exception if success is not true.

    final baseResponse = BaseResponse<String>.fromJson(
      response.data,
      (data) => data as String,
    );

    if (baseResponse.status == 200) {
      // Since API doesn't return the object, we can't return a full GigModel with ID.
      // We might have to refetch or return a dummy.
      // Let's return a dummy with success status for now.
      // Or better: The Cubit expects a GigEntity to add to list.
      // We should probably reload the list after add.
      return const GigModel(
        id: 'temp',
        title: '',
        description: '',
        price: 0,
        category: '',
        status: GigStatus.pending,
        coverImage: '',
        createdAt: null,
        // We will fix Model constructor to nullable createdAt
      );
    } else {
      throw ServerException(baseResponse.message);
    }
  }

  @override
  Future<GigModel> updateGig(String id, Map<String, dynamic> data) async {
    final Map<String, dynamic> formDataMap = {
      '_method': 'put',
      'ar_title': data['ar_title'] ?? '',
      'en_title': data['en_title'] ?? '',
      'ar_description': data['ar_description'] ?? '',
      'en_description': data['en_description'] ?? '',
      'category_id': data['category_id'] ?? '',
      'price': data['price'] ?? 0,
    };

    // Handle images - API expects indexed format: images[0], images[1], etc.
    if (data.containsKey('images') && data['images'] is List) {
      final List<String> imagePaths = List<String>.from(data['images']);
      for (int i = 0; i < imagePaths.length; i++) {
        formDataMap['images[$i]'] = await MultipartFile.fromFile(imagePaths[i]);
      }
    }

    // Handle days_availability - API expects indexed format
    if (data.containsKey('days_availability') &&
        data['days_availability'] is List) {
      final List<String> availability = List<String>.from(
        data['days_availability'],
      );
      for (int i = 0; i < availability.length; i++) {
        formDataMap['days_availability[$i]'] = availability[i];
      }
    }

    final formData = FormData.fromMap(formDataMap);

    final response = await _dioClient.post(
      '${ApiConstants.advertisements}/$id',
      data: formData,
    );

    final baseResponse = BaseResponse<String>.fromJson(
      response.data,
      (data) => data as String,
    );

    if (baseResponse.status == 200) {
      return const GigModel(
        id: 'temp',
        title: '',
        description: '',
        price: 0,
        category: '',
        status: GigStatus.pending,
        coverImage: '',
        createdAt: null,
      );
    } else {
      throw ServerException(baseResponse.message);
    }
  }

  @override
  Future<void> deleteGig(String id) async {
    await _dioClient.delete('${ApiConstants.advertisements}/$id');
    // Assuming delete also returns standard structure
    // If 200 OK
  }
}
