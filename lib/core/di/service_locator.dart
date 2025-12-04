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
import 'package:ehtirafy_app/features/client/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:ehtirafy_app/features/client/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:ehtirafy_app/features/client/notifications/domain/repositories/notifications_repository.dart';
import 'package:ehtirafy_app/features/client/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:ehtirafy_app/features/client/notifications/presentation/cubits/notifications_cubit.dart';
import 'package:ehtirafy_app/features/client/search/data/datasources/search_remote_data_source.dart';
import 'package:ehtirafy_app/features/client/search/data/repositories/search_repository_impl.dart';
import 'package:ehtirafy_app/features/client/search/domain/repositories/search_repository.dart';
import 'package:ehtirafy_app/features/client/search/domain/usecases/search_usecase.dart';
import 'package:ehtirafy_app/features/client/search/presentation/cubits/search_cubit.dart';
import 'package:ehtirafy_app/features/client/home/data/datasources/home_remote_data_source.dart';
import 'package:ehtirafy_app/features/client/home/data/repositories/home_repository_impl.dart';
import 'package:ehtirafy_app/features/client/home/domain/repositories/home_repository.dart';
import 'package:ehtirafy_app/features/client/home/domain/usecases/get_featured_photographers_usecase.dart';
import 'package:ehtirafy_app/features/client/home/presentation/cubits/home_cubit.dart';
import 'package:ehtirafy_app/features/client/freelancer/data/datasources/freelancer_remote_data_source.dart';
import 'package:ehtirafy_app/features/client/freelancer/data/repositories/freelancer_repository_impl.dart';
import 'package:ehtirafy_app/features/client/freelancer/domain/repositories/freelancer_repository.dart';
import 'package:ehtirafy_app/features/client/freelancer/domain/usecases/get_freelancer_profile_usecase.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/cubits/freelancer_cubit.dart';
import 'package:ehtirafy_app/features/client/booking/data/repositories/booking_repository_impl.dart';
import 'package:ehtirafy_app/features/client/booking/domain/repositories/booking_repository.dart';
import 'package:ehtirafy_app/features/client/booking/domain/usecases/submit_booking_request_usecase.dart';
import 'package:ehtirafy_app/features/client/booking/presentation/cubit/booking_cubit.dart';
import 'package:ehtirafy_app/features/client/contract/data/repositories/contract_repository_impl.dart';
import 'package:ehtirafy_app/features/client/contract/domain/repositories/contract_repository.dart';
import 'package:ehtirafy_app/features/client/contract/domain/usecases/get_contract_details_usecase.dart';
import 'package:ehtirafy_app/features/client/contract/presentation/manager/contract_details_cubit.dart';
import 'package:ehtirafy_app/features/shared/chat/data/datasources/chat_remote_data_source.dart';
import 'package:ehtirafy_app/features/shared/chat/data/repositories/chat_repository_impl.dart';
import 'package:ehtirafy_app/features/shared/chat/domain/repositories/chat_repository.dart';
import 'package:ehtirafy_app/features/shared/chat/domain/usecases/get_conversations_usecase.dart';
import 'package:ehtirafy_app/features/shared/chat/domain/usecases/get_messages_usecase.dart';
import 'package:ehtirafy_app/features/shared/chat/domain/usecases/send_message_usecase.dart';
import 'package:ehtirafy_app/features/shared/chat/presentation/cubit/chat_cubit.dart';
import 'package:ehtirafy_app/features/shared/profile/data/datasources/profile_remote_datasource.dart';
import 'package:ehtirafy_app/features/shared/profile/data/repositories/profile_repository_impl.dart';
import 'package:ehtirafy_app/features/shared/profile/domain/repositories/profile_repository.dart';
import 'package:ehtirafy_app/features/shared/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:ehtirafy_app/features/shared/profile/domain/usecases/switch_user_role_usecase.dart';
import 'package:ehtirafy_app/features/shared/profile/presentation/manager/profile_cubit.dart';

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
  // Features - Notifications
  sl.registerFactory(() => NotificationsCubit(getNotificationsUseCase: sl()));
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(),
  );
  // Features - Search
  sl.registerFactory(() => SearchCubit(searchUseCase: sl()));
  sl.registerLazySingleton(() => SearchUseCase(sl()));
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(),
  );
  // Features - Home
  sl.registerFactory(() => HomeCubit(getFeaturedPhotographersUseCase: sl()));
  sl.registerLazySingleton(() => GetFeaturedPhotographersUseCase(sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  // Features - Freelancer
  sl.registerFactory(() => FreelancerCubit(getFreelancerProfileUseCase: sl()));
  sl.registerLazySingleton(() => GetFreelancerProfileUseCase(sl()));
  sl.registerLazySingleton<FreelancerRepository>(
    () => FreelancerRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<FreelancerRemoteDataSource>(
    () => FreelancerRemoteDataSourceImpl(),
  );
  // Features - Booking
  // Booking Feature
  sl.registerFactory(() => BookingCubit(sl()));
  sl.registerLazySingleton(() => SubmitBookingRequestUseCase(sl()));
  sl.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl());
  // Features - Contract
  sl.registerFactory(
    () => ContractDetailsCubit(getContractDetailsUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetContractDetailsUseCase(sl()));
  sl.registerLazySingleton<ContractRepository>(() => ContractRepositoryImpl());

  // Features - Chat
  sl.registerFactory(
    () => ChatCubit(
      getConversationsUseCase: sl(),
      getMessagesUseCase: sl(),
      sendMessageUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetConversationsUseCase(sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(),
  );

  // Features - Profile
  sl.registerFactory(
    () =>
        ProfileCubit(getUserProfileUseCase: sl(), switchUserRoleUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => SwitchUserRoleUseCase(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );
}
