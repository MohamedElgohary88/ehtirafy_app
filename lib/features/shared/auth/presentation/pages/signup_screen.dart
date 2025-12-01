import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/primary_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.xxl),
              Text(
                AppStrings.authSignupTitle.tr(),
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                AppStrings.authSignupSubtitle.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppSpacing.xl),
              CustomTextField(
                label: AppStrings.authFullNameLabel.tr(),
                hint: AppStrings.authFullNameHint.tr(),
              ),
              SizedBox(height: AppSpacing.md),
              CustomTextField(
                label: AppStrings.authEmailLabel.tr(),
                hint: AppStrings.authEmailHint.tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: AppSpacing.md),
              CustomTextField(
                label: AppStrings.authPasswordLabel.tr(),
                hint: AppStrings.authPasswordHint.tr(),
                isPassword: true,
              ),
              SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                text: AppStrings.authSignupButton.tr(),
                onPressed: () {
                  // TODO: Implement signup flow
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
