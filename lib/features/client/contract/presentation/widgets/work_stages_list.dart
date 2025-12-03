import 'package:easy_localization/easy_localization.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkStagesList extends StatelessWidget {
  final ContractDetailsEntity contract;

  const WorkStagesList({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.contractWorkStagesLabel.tr(),
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          _buildStageItem(
            title: AppStrings.contractStageConfirmBooking.tr(),
            isCompleted: true,
            isLast: false,
          ),
          _buildStageItem(
            title: AppStrings.contractStageShooting.tr(),
            isCurrent: true,
            isLast: false,
          ),
          _buildStageItem(
            title: AppStrings.contractStageDeliveringPhotos.tr(),
            isPending: true,
            isLast: false,
          ),
          _buildStageItem(
            title: AppStrings.contractFinishService.tr(),
            isPending: true,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStageItem({
    required String title,
    bool isCompleted = false,
    bool isCurrent = false,
    bool isPending = false,
    required bool isLast,
  }) {
    Color color;
    IconData icon;

    if (isCompleted) {
      color = AppColors.success;
      icon = Icons.check;
    } else if (isCurrent) {
      color = AppColors.primary;
      icon = Icons.circle;
    } else {
      color = AppColors.grey300;
      icon = Icons.circle_outlined;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: isCompleted ? color : Colors.transparent,
                  border: Border.all(color: color, width: 2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(icon, color: Colors.white, size: 14.sp)
                      : isCurrent
                      ? Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        )
                      : null,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? AppColors.success : AppColors.grey200,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isPending
                        ? AppColors.grey400
                        : AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                SizedBox(height: 32.h), // Spacing between items
              ],
            ),
          ),
        ],
      ),
    );
  }
}
