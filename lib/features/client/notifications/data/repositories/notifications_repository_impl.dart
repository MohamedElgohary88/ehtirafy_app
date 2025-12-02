import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/client/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:ehtirafy_app/features/client/notifications/domain/entities/notification_entity.dart';
import 'package:ehtirafy_app/features/client/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      final remoteNotifications = await remoteDataSource.getNotifications();
      return Right(remoteNotifications);
    } catch (e) {
      // In a real app, we would handle specific exceptions here
      return Left(ServerFailure(e.toString()));
    }
  }
}
