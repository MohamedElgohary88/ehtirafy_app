import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/shared/auth/data/datasources/user_local_data_source.dart';
import 'package:ehtirafy_app/features/client/home/domain/usecases/get_featured_photographers_usecase.dart';
import 'package:ehtirafy_app/features/client/home/presentation/cubits/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetFeaturedPhotographersUseCase getFeaturedPhotographersUseCase;
  final UserLocalDataSource userLocalDataSource;

  HomeCubit({
    required this.getFeaturedPhotographersUseCase,
    required this.userLocalDataSource,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    final user = await userLocalDataSource.getUser();
    final result = await getFeaturedPhotographersUseCase();
    result.fold((failure) => emit(HomeError(_mapFailureToMessage(failure))), (
      photographers,
    ) {
      emit(
        HomeLoaded(
          featuredPhotographers: photographers,
          userName: user?.name ?? 'عميلنا العزيز',
        ),
      );
    });
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
