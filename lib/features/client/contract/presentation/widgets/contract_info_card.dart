import 'package:easy_localization/easy_localization.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractInfoCard extends StatelessWidget {
  final ContractDetailsEntity contract;
  final VoidCallback? onChat;

  const ContractInfoCard({super.key, required this.contract, this.onChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            AppStrings.contractDescriptionLabel.tr(),
            contract.description,
            isDescription: true,
          ),
          Divider(color: Colors.white10, height: 24.h),
          _buildInfoRow(
            AppStrings.contractLocationLabel.tr(),
            contract.location,
            icon: Icons.location_on_outlined,
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
            AppStrings.contractDateLabel.tr(),
            DateFormat('d MMMM yyyy', 'ar').format(contract.date),
            icon: Icons.calendar_today_outlined,
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
            AppStrings.contractBudgetLabel.tr(),
            '${NumberFormat('#,###').format(contract.budget)} ${AppStrings.bookingCurrency.tr()}',
            icon: Icons.monetization_on_outlined,
            isBudget: true,
          ),
          Divider(color: Colors.white10, height: 24.h),
          _buildPhotographerInfo(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    bool isDescription = false,
    IconData? icon,
    bool isBudget = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.grey500, fontSize: 12.sp),
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.primary, size: 18.sp),
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: isBudget ? AppColors.success : AppColors.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: isBudget ? FontWeight.bold : FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhotographerInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage: NetworkImage(contract.photographerImage),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.bookingPhotographer.tr(),
              style: TextStyle(color: AppColors.grey500, fontSize: 12.sp),
            ),
            Text(
              contract.photographerName,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: contract.isChatAllowed ? onChat : null,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: contract.isChatAllowed
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.grey200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              color: contract.isChatAllowed
                  ? AppColors.primary
                  : AppColors.grey400,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
