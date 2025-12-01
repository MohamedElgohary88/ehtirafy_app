import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(AppStrings.bookingServiceWedding.tr()),
              background: Container(color: AppColors.grey800),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.bookingDescriptionLabel.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Text(AppStrings.bookingDescriptionPlaceholder.tr()),
                    SizedBox(height: AppSpacing.lg),
                    Text(
                      '${AppStrings.bookingPriceLabel.tr()}: 5000 ${AppStrings.bookingCurrency.tr()}',
                      style: theme.textTheme.titleMedium?.copyWith(color: AppColors.gold, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: PrimaryButton(
            text: AppStrings.bookingBookButton.tr(),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

