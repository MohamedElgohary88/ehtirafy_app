import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/errors/failures.dart';
import 'package:ehtirafy_app/features/client/notifications/domain/entities/notification_entity.dart';
import 'package:ehtirafy_app/features/client/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:ehtirafy_app/features/client/notifications/presentation/cubits/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  List<NotificationEntity> _allNotifications = [];

  NotificationsCubit({required this.getNotificationsUseCase})
    : super(NotificationsInitial());

  Future<void> getNotifications() async {
    emit(NotificationsLoading());
    final result = await getNotificationsUseCase();
    result.fold(
      (failure) => emit(NotificationsError(_mapFailureToMessage(failure))),
      (notifications) {
        _allNotifications = notifications;
        emit(NotificationsLoaded(notifications: notifications));
      },
    );
  }

  void filterNotifications(String filter) {
    if (state is NotificationsLoaded) {
      if (filter == 'unread') {
        final unread = _allNotifications.where((n) => n.isUnread).toList();
        emit(NotificationsLoaded(notifications: unread, filter: filter));
      } else {
        emit(
          NotificationsLoaded(notifications: _allNotifications, filter: filter),
        );
      }
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
