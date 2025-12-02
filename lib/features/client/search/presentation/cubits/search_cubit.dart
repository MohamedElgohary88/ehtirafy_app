import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/client/search/domain/usecases/search_usecase.dart';
import 'package:ehtirafy_app/features/client/search/presentation/cubits/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase searchUseCase;

  SearchCubit({required this.searchUseCase}) : super(SearchInitial());

  Future<void> loadInitialData() async {
    emit(SearchLoading());
    final recentResult = await searchUseCase.getRecentSearches();
    final popularResult = await searchUseCase.getPopularTags();

    recentResult.fold(
      (failure) => emit(SearchError(_mapFailureToMessage(failure))),
      (recent) {
        popularResult.fold(
          (failure) => emit(SearchError(_mapFailureToMessage(failure))),
          (popular) {
            emit(SearchLoaded(recentSearches: recent, popularTags: popular));
          },
        );
      },
    );
  }

  Future<void> search(String query) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      emit(SearchLoading());
      final result = await searchUseCase.search(query);
      result.fold(
        (failure) => emit(SearchError(_mapFailureToMessage(failure))),
        (results) {
          emit(
            SearchLoaded(
              recentSearches: currentState.recentSearches,
              popularTags: currentState.popularTags,
              searchResults: results,
            ),
          );
        },
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.failureServer;
      case CacheFailure:
        return AppStrings.failureCache;
      case NetworkFailure:
        return AppStrings.failureNetwork;
      default:
        return AppStrings.failureUnexpected;
    }
  }
}
