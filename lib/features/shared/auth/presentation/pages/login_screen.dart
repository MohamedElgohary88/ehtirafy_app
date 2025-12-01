import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 80.r,
                  color: AppColors.gold,
                ),
              ),
              SizedBox(height: AppSpacing.xxl),
              Text(
                AppStrings.authWelcomeBack.tr(),
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                AppStrings.authLoginSubtitle.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppSpacing.xl),
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
              SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.authForgotPassword.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                text: AppStrings.authLoginButton.tr(),
                onPressed: () {
                  context.go('/client/home');
                },
              ),
              SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.authNoAccount.tr(),
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/auth/signup');
                    },
                    child: Text(
                      AppStrings.authCreateAccount.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
