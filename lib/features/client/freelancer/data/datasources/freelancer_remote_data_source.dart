import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/features/client/freelancer/data/models/freelancer_model.dart';

abstract class FreelancerRemoteDataSource {
  Future<FreelancerModel> getFreelancerProfile(String id);
}

class FreelancerRemoteDataSourceImpl implements FreelancerRemoteDataSource {
  @override
  Future<FreelancerModel> getFreelancerProfile(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return FreelancerModel.fromJson(AppMockData.mockFreelancerProfile);
  }
}
