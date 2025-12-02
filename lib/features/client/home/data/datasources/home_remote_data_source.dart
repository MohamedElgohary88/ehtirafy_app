import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/features/client/home/data/models/photographer_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PhotographerModel>> getFeaturedPhotographers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl();

  @override
  Future<List<PhotographerModel>> getFeaturedPhotographers() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return AppMockData.photographers
        .map((e) => PhotographerModel.fromJson(e))
        .toList();
  }
}
