import 'package:dio/dio.dart';
import 'package:ehtirafy_app/core/network/api_constants.dart';
import 'package:ehtirafy_app/core/network/dio_client.dart';
import 'package:ehtirafy_app/features/freelancer/data/models/gig_model.dart';
import 'package:ehtirafy_app/features/freelancer/domain/entities/gig_entity.dart';
import 'package:ehtirafy_app/core/network/base_response.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';

abstract class FreelancerGigsRemoteDataSource {
  /// Get gigs with user_type parameter
  /// - user_type=freelancer → Freelancer (photographer) sees their own gigs
  /// - user_type=customer → Customer (client) sees all available ads
  Future<List<GigModel>> getGigs({String userType = 'freelancer'});

  /// Get advertisement/gig details by ID
  Future<GigModel> getGigById(String id);

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
  Future<GigModel> addGig(Map<String, dynamic> data) async {
    final Map<String, dynamic> requestData = Map.from(data);

    // Handle images
    if (requestData.containsKey('images') && requestData['images'] is List) {
      final List<String> imagePaths = requestData['images'];
      requestData.remove('images');

      final List<MultipartFile> files = [];
      for (var path in imagePaths) {
        files.add(await MultipartFile.fromFile(path));
      }

      // Using 'images[]' as key for array of files as per common backend conventions
      // If specific indexed keys are needed (images[0]), we would loop and add keys.
      // But Dio FormData usually handles 'images[]' with list of files well.
      requestData['images[]'] = files;
    }

    final formData = FormData.fromMap(requestData);

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
    final Map<String, dynamic> requestData = Map.from(data);
    requestData['_method'] = 'put';

    // Handle images for update
    if (requestData.containsKey('images') && requestData['images'] is List) {
      final List<String> imagePaths = requestData['images'];
      requestData.remove('images');

      final List<MultipartFile> files = [];
      for (var path in imagePaths) {
        files.add(await MultipartFile.fromFile(path));
      }
      requestData['images[]'] = files;
    }

    final formData = FormData.fromMap(requestData);

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
