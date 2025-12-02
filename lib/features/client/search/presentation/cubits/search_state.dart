import 'package:equatable/equatable.dart';
import 'package:ehtirafy_app/features/client/search/domain/entities/search_result_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<SearchResultEntity> recentSearches;
  final List<SearchResultEntity> popularTags;
  final List<SearchResultEntity>? searchResults;

  const SearchLoaded({
    required this.recentSearches,
    required this.popularTags,
    this.searchResults,
  });

  @override
  List<Object> get props => [recentSearches, popularTags, searchResults ?? []];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
