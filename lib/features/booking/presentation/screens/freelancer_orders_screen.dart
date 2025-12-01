import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class FreelancerOrdersScreen extends StatelessWidget {
  const FreelancerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.freelancerOrdersTitle.tr())),
      body: ListView.separated(
        padding: EdgeInsets.all(AppSpacing.lg),
        itemCount: 4,
        separatorBuilder: (_, __) => SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.grey600,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            title: Text(AppStrings.bookingServiceWedding.tr()),
            subtitle: Text('${AppStrings.bookingClientPrefix.tr()} خالد • 5000 ${AppStrings.bookingCurrency.tr()}'),
            trailing: Chip(label: Text(AppStrings.freelancerOrderNew.tr())),
          ),
        ),
      ),
    );
  }
}
