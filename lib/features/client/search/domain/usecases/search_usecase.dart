import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/client/search/domain/entities/search_result_entity.dart';
import 'package:ehtirafy_app/features/client/search/domain/repositories/search_repository.dart';

class SearchUseCase {
  final SearchRepository repository;

  SearchUseCase(this.repository);

  Future<Either<Failure, List<SearchResultEntity>>> getRecentSearches() async {
    return await repository.getRecentSearches();
  }

  Future<Either<Failure, List<SearchResultEntity>>> getPopularTags() async {
    return await repository.getPopularTags();
  }

  Future<Either<Failure, List<SearchResultEntity>>> search(String query) async {
    return await repository.search(query);
  }
}
