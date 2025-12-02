import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildFilterTabs(context),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(24.w),
                children: [
                  _buildNotificationItem(
                    context,
                    title: 'رسالة جديدة من أحمد المصور',
                    body: 'شكراً لك، سأكون جاهزاً في الموعد',
                    time: 'منذ 5 دقائق',
                    isUnread: true,
                    iconColor: AppColors.gold,
                  ),
                  SizedBox(height: 12.h),
                  _buildNotificationItem(
                    context,
                    title: 'تم إتمام الخدمة',
                    body: 'محمد الفوتوغرافي أكمل الخدمة',
                    time: 'منذ 3 ساعات',
                    isUnread: true,
                    iconColor: AppColors.success,
                  ),
                  SizedBox(height: 12.h),
                  _buildNotificationItem(
                    context,
                    title: 'تذكير: قيّم المصور',
                    body: 'شارك تجربتك مع محمد',
                    time: 'منذ 5 ساعات',
                    isUnread: false,
                    iconColor: AppColors.gold.withOpacity(0.5),
                  ),
                  SizedBox(height: 12.h),
                  _buildNotificationItem(
                    context,
                    title: 'تم إيداع المبلغ',
                    body: 'تم إيداع 5,000 ريال بشكل آمن',
                    time: 'منذ يوم',
                    isUnread: false,
                    iconColor: AppColors.success,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Text(
                AppStrings.notificationsMarkAllRead.tr(),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.gold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
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
          SizedBox(width: 40.w), // Placeholder for balance
        ],
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
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
            isSelected: false,
          ),
          _buildTab(
            context,
            text: AppStrings.notificationsAll.tr(),
            isSelected: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String text,
    required bool isSelected,
  }) {
    return Expanded(
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
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required String title,
    required String body,
    required String time,
    required bool isUnread,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.gold.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isUnread ? AppColors.gold.withOpacity(0.2) : AppColors.grey200,
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
                    if (isUnread)
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
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  body,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.grey600),
                ),
                SizedBox(height: 8.h),
                Text(
                  time,
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
              color: iconColor.withOpacity(0.1),
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
