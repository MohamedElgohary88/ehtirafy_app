import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';


class MyGigsScreen extends StatelessWidget {
  const MyGigsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.freelancerMyGigsTitle.tr())),
      body: GridView.builder(
        padding: EdgeInsets.all(AppSpacing.lg),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: AppColors.grey800,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey700),
          ),
          child: Column(
            children: [
              Expanded(child: Container(color: AppColors.grey600)),
              Padding(
                padding: EdgeInsets.all(AppSpacing.sm),
                child: Text(AppStrings.freelancerGigSampleTitle.tr(), maxLines: 1, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.dark,
        child: const Icon(Icons.add),
      ),
    );
  }
}

