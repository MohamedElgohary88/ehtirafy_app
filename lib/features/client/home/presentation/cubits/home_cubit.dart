import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/features/client/home/domain/entities/app_statistics.dart';
import 'package:ehtirafy_app/features/client/home/domain/entities/category_entity.dart';
import 'package:ehtirafy_app/features/client/home/domain/entities/photographer_entity.dart';
import 'package:ehtirafy_app/features/client/home/domain/usecases/get_app_statistics_usecase.dart';
import 'package:ehtirafy_app/features/client/home/domain/usecases/get_categories_usecase.dart';
import 'package:ehtirafy_app/features/client/home/domain/usecases/get_featured_photographers_usecase.dart';
import 'package:ehtirafy_app/features/client/home/presentation/cubits/home_state.dart';
import 'package:ehtirafy_app/features/shared/auth/data/datasources/user_local_data_source.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetFeaturedPhotographersUseCase getFeaturedPhotographersUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetAppStatisticsUseCase getAppStatisticsUseCase;
  final UserLocalDataSource userLocalDataSource;

  HomeCubit({
    required this.getFeaturedPhotographersUseCase,
    required this.getCategoriesUseCase,
    required this.getAppStatisticsUseCase,
    required this.userLocalDataSource,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    final user = await userLocalDataSource.getUser();

    // Fetch in parallel
    final results = await Future.wait([
      getFeaturedPhotographersUseCase(),
      getCategoriesUseCase(),
      getAppStatisticsUseCase(),
    ]);

    final photographersResult =
        results[0] as Either<Failure, List<PhotographerEntity>>;
    final categoriesResult =
        results[1] as Either<Failure, List<CategoryEntity>>;
    final statsResult = results[2] as Either<Failure, AppStatistics>;

    photographersResult.fold(
      (failure) => emit(HomeError(_mapFailureToMessage(failure))),
      (photographers) {
        categoriesResult.fold(
          (failure) => _emitLoaded(photographers, [], null, user?.name),
          (categories) {
            statsResult.fold(
              (failure) =>
                  _emitLoaded(photographers, categories, null, user?.name),
              (stats) =>
                  _emitLoaded(photographers, categories, stats, user?.name),
            );
          },
        );
      },
    );
  }

  void _emitLoaded(
    List<PhotographerEntity> photographers,
    List<CategoryEntity> categories,
    AppStatistics? stats,
    String? userName,
  ) {
    emit(
      HomeLoaded(
        featuredPhotographers: photographers,
        categories: categories,
        appStatistics: stats,
        userName: userName ?? 'عميلنا العزيز',
      ),
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
