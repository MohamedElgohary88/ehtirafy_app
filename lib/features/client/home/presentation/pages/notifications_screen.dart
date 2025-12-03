import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';
import 'package:ehtirafy_app/features/client/notifications/presentation/cubits/notifications_cubit.dart';
import 'package:ehtirafy_app/features/client/notifications/presentation/cubits/notifications_state.dart';
import 'package:ehtirafy_app/features/client/notifications/domain/entities/notification_entity.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationsCubit>()..getNotifications(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NotificationsError) {
                    return Center(child: Text(state.message.tr()));
                  } else if (state is NotificationsLoaded) {
                    return Column(
                      children: [
                        _buildFilterTabs(context, state.filter),
                        Expanded(
                          child: state.notifications.isEmpty
                              ? Center(
                                  child: Text(
                                    AppStrings.notificationsEmpty.tr(),
                                  ),
                                )
                              : ListView.separated(
                                  padding: EdgeInsets.all(24.w),
                                  itemCount: state.notifications.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 12.h),
                                  itemBuilder: (context, index) {
                                    return _buildNotificationItem(
                                      context,
                                      state.notifications[index],
                                    );
                                  },
                                ),
                        ),
                        if (state.notifications.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.all(24.w),
                            child: Text(
                              AppStrings.notificationsMarkAllRead.tr(),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.gold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.dark,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Status Bar Color Match
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              decoration: const BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    AppStrings.notificationsTitle.tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 40.w), // Placeholder for balance/alignment
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context, String currentFilter) {
    return Container(
      margin: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          _buildTab(
            context,
            text: AppStrings.notificationsUnread.tr(),
            isSelected: currentFilter == 'unread',
            onTap: () => context.read<NotificationsCubit>().filterNotifications(
              'unread',
            ),
          ),
          _buildTab(
            context,
            text: AppStrings.notificationsAll.tr(),
            isSelected: currentFilter == 'all',
            onTap: () =>
                context.read<NotificationsCubit>().filterNotifications('all'),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.gold : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected ? Colors.white : AppColors.grey600,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    NotificationEntity notification,
  ) {
    Color iconColor;
    if (notification.type == 'success') {
      iconColor = AppColors.success;
    } else if (notification.type == 'info') {
      iconColor = AppColors.gold.withValues(alpha: 0.5);
    } else {
      iconColor = AppColors.gold;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: notification.isUnread
            ? AppColors.gold.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: notification.isUnread
              ? AppColors.gold.withValues(alpha: 0.2)
              : AppColors.grey200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (notification.isUnread)
                      Container(
                        width: 8.w,
                        height: 8.w,
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: const BoxDecoration(
                          color: AppColors.gold,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        notification.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.body,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.grey600),
                ),
                SizedBox(height: 8.h),
                Text(
                  notification.time,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.grey400),
                ),
              ],
            ),
          ),
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: iconColor,
              size: 24.w,
            ),
          ),
        ],
      ),
    );
  }
}
