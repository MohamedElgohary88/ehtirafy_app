import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/shared/auth/data/datasources/user_local_data_source.dart';
import 'package:ehtirafy_app/features/client/home/domain/usecases/get_featured_photographers_usecase.dart';
import 'package:ehtirafy_app/features/client/home/domain/usecases/get_categories_usecase.dart';
import 'package:ehtirafy_app/features/client/home/presentation/cubits/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetFeaturedPhotographersUseCase getFeaturedPhotographersUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final UserLocalDataSource userLocalDataSource;

  HomeCubit({
    required this.getFeaturedPhotographersUseCase,
    required this.getCategoriesUseCase,
    required this.userLocalDataSource,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    final user = await userLocalDataSource.getUser();

    // Fetch photographers and categories in parallel
    final photographersResult = await getFeaturedPhotographersUseCase();
    final categoriesResult = await getCategoriesUseCase();

    // Handle photographers result
    photographersResult.fold(
      (failure) => emit(HomeError(_mapFailureToMessage(failure))),
      (photographers) {
        // Handle categories result
        categoriesResult.fold(
          (failure) {
            // If categories fail, still show home with empty categories
            emit(
              HomeLoaded(
                featuredPhotographers: photographers,
                categories: [],
                userName: user?.name ?? 'عميلنا العزيز',
              ),
            );
          },
          (categories) {
            emit(
              HomeLoaded(
                featuredPhotographers: photographers,
                categories: categories,
                userName: user?.name ?? 'عميلنا العزيز',
              ),
            );
          },
        );
      },
    );
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
