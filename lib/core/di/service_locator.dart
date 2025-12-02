import 'package:get_it/get_it.dart';
import 'package:ehtirafy_app/features/shared/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ehtirafy_app/features/shared/auth/data/repositories/auth_repository_impl.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/repositories/auth_repository.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/usecases/login_usecase.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/usecases/signup_usecase.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/cubits/login_cubit.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/cubits/signup_cubit.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/cubits/otp_cubit.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/repositories/role_repository.dart';
import 'package:ehtirafy_app/features/shared/auth/data/repositories/role_repository_impl.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/usecases/role_usecases.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/cubits/role_cubit.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Data layer
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<RoleRepository>(() => RoleRepositoryImpl());

  // Domain layer
  sl.registerFactory<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerFactory<SignupUseCase>(() => SignupUseCase(sl<AuthRepository>()));
  sl.registerFactory<GetRoleUseCase>(() => GetRoleUseCase(sl()));
  sl.registerFactory<SetRoleUseCase>(() => SetRoleUseCase(sl()));

  // Presentation layer
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl<LoginUseCase>()));
  sl.registerFactory<SignupCubit>(() => SignupCubit(sl<SignupUseCase>()));
  sl.registerFactory<OtpCubit>(() => OtpCubit());
  sl.registerFactory<RoleCubit>(
    () => RoleCubit(sl<GetRoleUseCase>(), sl<SetRoleUseCase>()),
  );
}
