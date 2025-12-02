import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/features/client/notifications/data/models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  // In a real app, this would inject ApiService
  // final ApiService apiService;

  NotificationsRemoteDataSourceImpl();

  @override
  Future<List<NotificationModel>> getNotifications() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return mock data
    return AppMockData.notifications
        .map((e) => NotificationModel.fromJson(e))
        .toList();
  }
}
