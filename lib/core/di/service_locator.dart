import 'package:get_it/get_it.dart';
import 'package:ehtirafy_app/features/shared/auth/data/services/auth_api_service.dart';
import 'package:ehtirafy_app/features/shared/auth/data/repositories/auth_repository_impl.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/repositories/auth_repository.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/usecases/login_usecase.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/cubits/login_cubit.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Data layer
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // Domain layer
  sl.registerFactory<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()));

  // Presentation layer
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl<LoginUseCase>()));
}
