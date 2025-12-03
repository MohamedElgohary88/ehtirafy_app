import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';

class RequestsFilterTab extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const RequestsFilterTab({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: double.infinity,
      padding: EdgeInsets.only(left: 0.02.w),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFE5E5E5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTabItem(
            context,
            index: 2,
            title: AppStrings.myRequestsTabCompleted.tr(),
          ),
          _buildTabItem(
            context,
            index: 1,
            title: AppStrings.myRequestsTabUnderReview.tr(),
          ),
          _buildTabItem(
            context,
            index: 0,
            title: AppStrings.myRequestsTabActive.tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context, {
    required int index,
    required String title,
  }) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: Container(
          height: 39.h,
          padding: EdgeInsets.only(
            top: 4.h,
            left: 8.w,
            right: 8.w,
            bottom: 12.h,
          ),
          decoration: ShapeDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: isSelected ? 2 : 0,
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppColors.primary : const Color(0xFF0A0A0A),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
