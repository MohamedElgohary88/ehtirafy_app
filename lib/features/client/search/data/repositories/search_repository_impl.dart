import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/client/search/data/datasources/search_remote_data_source.dart';
import 'package:ehtirafy_app/features/client/search/domain/entities/search_result_entity.dart';
import 'package:ehtirafy_app/features/client/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SearchResultEntity>>> getRecentSearches() async {
    try {
      final result = await remoteDataSource.getRecentSearches();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchResultEntity>>> getPopularTags() async {
    try {
      final result = await remoteDataSource.getPopularTags();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchResultEntity>>> search(String query) async {
    try {
      final result = await remoteDataSource.search(query);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
