import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/features/client/search/data/models/search_result_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultModel>> getRecentSearches();
  Future<List<SearchResultModel>> getPopularTags();
  Future<List<SearchResultModel>> search(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  SearchRemoteDataSourceImpl();

  @override
  Future<List<SearchResultModel>> getRecentSearches() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AppMockData.recentSearches
        .asMap()
        .entries
        .map(
          (e) => SearchResultModel(
            id: e.key.toString(),
            title: e.value,
            type: 'recent',
          ),
        )
        .toList();
  }

  @override
  Future<List<SearchResultModel>> getPopularTags() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AppMockData.popularSearchTags
        .asMap()
        .entries
        .map(
          (e) => SearchResultModel(
            id: e.key.toString(),
            title: e.value,
            type: 'popular',
          ),
        )
        .toList();
  }

  @override
  Future<List<SearchResultModel>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // Mock search logic
    return [
      SearchResultModel(id: '1', title: 'Result 1 for $query', type: 'result'),
      SearchResultModel(id: '2', title: 'Result 2 for $query', type: 'result'),
    ];
  }
}
