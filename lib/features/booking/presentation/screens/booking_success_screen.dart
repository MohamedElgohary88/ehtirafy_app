import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF9F9F9)],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
          child: Column(
            children: [
              _buildSuccessIcon(),
              SizedBox(height: 24.h),
              Text(
                AppStrings.bookingSuccessTitle.tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF2B2B2B),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                AppStrings.bookingSuccessSubtitle.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF888888),
                  height: 1.6,
                ),
              ),
              SizedBox(height: 40.h),
              _buildStepsList(),
              SizedBox(height: 40.h),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 112.w,
      height: 112.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC8A44F), Color(0xFFB8944F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 50,
            offset: const Offset(0, 25),
            spreadRadius: -12,
          ),
        ],
      ),
      child: const Icon(Icons.check, color: Colors.white, size: 56),
    );
  }

  Widget _buildStepsList() {
    return Column(
      children: [
        _buildStepItem(
          title: AppStrings.bookingStep1Title.tr(),
          subtitle: AppStrings.bookingStep1Desc.tr(),
          icon: Icons.access_time,
          iconColor: const Color(0xFFC8A44F),
          iconBgColor: const Color(0xFFC8A44F).withOpacity(0.1),
        ),
        SizedBox(height: 12.h),
        _buildStepItem(
          title: AppStrings.bookingStep2Title.tr(),
          subtitle: AppStrings.bookingStep2Desc.tr(),
          icon: Icons.notifications_none,
          iconColor: const Color(0xFF17A2B8),
          iconBgColor: const Color(0xFF17A2B8).withOpacity(0.1),
        ),
        SizedBox(height: 12.h),
        _buildStepItem(
          title: AppStrings.bookingStep3Title.tr(),
          subtitle: AppStrings.bookingStep3Desc.tr(),
          icon: Icons.check_circle_outline,
          iconColor: const Color(0xFF28A745),
          iconBgColor: const Color(0xFF28A745).withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _buildStepItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton(
            onPressed: () {
              context.push('/my-requests');
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFC8A44F), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              AppStrings.bookingViewRequestsButton.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFC8A44F),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {
              context.go('/home');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC8A44F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              elevation: 4,
            ),
            child: Text(
              AppStrings.bookingBackHomeButton.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
