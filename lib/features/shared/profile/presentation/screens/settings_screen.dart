import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../widgets/profile_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B2B2B),
        elevation: 0,
        title: Text(
          'profile.menu.settings'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            ProfileTile(
              title: 'settings.change_password'.tr(),
              icon: Icons.lock_outline,
              onTap: () {
                // Navigate to Change Password
              },
            ),
            SizedBox(height: 12.h),
            ProfileTile(
              title: 'settings.language'.tr(),
              icon: Icons.language,
              onTap: () {
                // Navigate to Language Selection
              },
            ),
            SizedBox(height: 12.h),
            ProfileTile(
              title: 'settings.notifications'.tr(),
              icon: Icons.notifications_outlined,
              onTap: () {
                // Navigate to Notification Settings
              },
            ),
            SizedBox(height: 12.h),
            ProfileTile(
              title: 'settings.help_support'.tr(),
              icon: Icons.help_outline,
              onTap: () {
                // Navigate to Help & Support
              },
            ),
            SizedBox(height: 12.h),
            ProfileTile(
              title: 'settings.privacy_policy'.tr(),
              icon: Icons.privacy_tip_outlined,
              onTap: () {
                // Navigate to Privacy Policy
              },
            ),
            SizedBox(height: 12.h),
            ProfileTile(
              title: 'settings.terms_conditions'.tr(),
              icon: Icons.description_outlined,
              onTap: () {
                // Navigate to Terms & Conditions
              },
            ),
          ],
        ),
      ),
    );
  }
}
