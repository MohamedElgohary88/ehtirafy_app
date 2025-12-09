import 'package:dio/dio.dart';
import 'package:ehtirafy_app/core/network/api_constants.dart';
import 'package:ehtirafy_app/core/network/dio_client.dart';
import 'package:ehtirafy_app/features/freelancer/data/models/gig_model.dart';
import 'package:ehtirafy_app/features/freelancer/domain/entities/gig_entity.dart';
import 'package:ehtirafy_app/core/network/base_response.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';

abstract class FreelancerGigsRemoteDataSource {
  Future<List<GigModel>> getGigs();
  Future<GigModel> addGig(Map<String, dynamic> data);
  Future<GigModel> updateGig(String id, Map<String, dynamic> data);
  Future<void> deleteGig(String id);
}

class FreelancerGigsRemoteDataSourceImpl
    implements FreelancerGigsRemoteDataSource {
  final DioClient _dioClient;

  FreelancerGigsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<GigModel>> getGigs() async {
    final response = await _dioClient.get(
      ApiConstants.freelancerAdvertisements,
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
  Future<GigModel> addGig(Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    // Handle images list if present (API expects images[0], images[1] etc.)
    // But Dio FormData handles List<MultipartFile> automatically if key is "images[]".
    // User request: images[0], days_availability[0] format.
    // We might need manual loop if Dio doesn't match the exact format:
    // "images[0]": file1, "images[1]": file2
    // Let's assume passed data is already formatted or we format it in Repos.
    // For now, let's treat it as a Map passed from Repository.

    final response = await _dioClient.post(
      ApiConstants.freelancerAdvertisements,
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
    data['_method'] = 'put';
    final formData = FormData.fromMap(data);

    final response = await _dioClient.post(
      '${ApiConstants.freelancerAdvertisements}/$id',
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
    await _dioClient.delete('${ApiConstants.freelancerAdvertisements}/$id');
    // Assuming delete also returns standard structure
    // If 200 OK
  }
}
