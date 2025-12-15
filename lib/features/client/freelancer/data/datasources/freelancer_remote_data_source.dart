import 'package:ehtirafy_app/core/network/dio_client.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/features/client/freelancer/data/models/freelancer_model.dart';

abstract class FreelancerRemoteDataSource {
  Future<FreelancerModel> getFreelancerProfile(String id);
}

class FreelancerRemoteDataSourceImpl implements FreelancerRemoteDataSource {
  final DioClient dioClient;

  FreelancerRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<FreelancerModel> getFreelancerProfile(String id) async {
    try {
      final response = await dioClient.get(
        '/api/v1/get-freelancer-profile/$id',
      );

      if (response.statusCode == 200) {
        return FreelancerModel.fromJson(response.data['data']);
      } else {
        throw ServerException(response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
