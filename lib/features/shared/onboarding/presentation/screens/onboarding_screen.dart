import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/core/widgets/feature_card.dart';
import 'package:ehtirafy_app/core/widgets/primary_button.dart';
import 'package:ehtirafy_app/core/widgets/secondary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                _HeaderSection(),
                SizedBox(height: 24),
                _FeatureGrid(),
                SizedBox(height: 24),
                _BannerSection(),
                SizedBox(height: 24),
                _FooterActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          Container(
            width: 96.w,
            height: 96.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.5, 0),
                end: const Alignment(0.5, 1),
                colors: [
                  AppColors.gold,
                  AppColors.gold.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(0, 8),
                  spreadRadius: -6,
                ),
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 25,
                  offset: Offset(0, 20),
                  spreadRadius: -5,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/camera_icon.svg',
              width: 64.w,
              height: 64.w,
              colorFilter: const ColorFilter.mode(AppColors.textLight, BlendMode.srcIn),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'onboarding.welcomeTitle'.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              color: isDark ? AppColors.textLight : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 0.75.sw,
            child: Text(
              'onboarding.subtitle'.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark ? AppColors.grey400 : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid();

  @override
  Widget build(BuildContext context) {
    final iconColor = AppColors.gold;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      childAspectRatio: 0.92,
      children: [
        FeatureCard(
          icon: _svgIcon('assets/icons/icon_services.svg', iconColor),
          title: 'services'.tr(),
          subtitle: 'onboarding.servicesSubtitle'.tr(),
          hasShadow: false,
        ),
        FeatureCard(
          icon: _svgIcon('assets/icons/icon_photographers.svg', iconColor),
          title: 'role.freelancer'.tr(),
          subtitle: 'onboarding.photographersSubtitle'.tr(),
        ),
        FeatureCard(
          icon: _svgIcon('assets/icons/icon_growth.svg', iconColor),
          title: 'growth'.tr(),
          subtitle: 'onboarding.growthSubtitle'.tr(),
        ),
        FeatureCard(
          icon: _svgIcon('assets/icons/icon_quality.svg', iconColor),
          title: 'quality'.tr(),
          subtitle: 'onboarding.qualitySubtitle'.tr(),
        ),
      ],
    );
  }

  Widget _svgIcon(String path, Color color) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0, 0),
            end: const Alignment(1, 1),
            colors: [
              AppColors.gold.withValues(alpha: 0.2),
              AppColors.gold.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        width: 56.w,
        height: 56.w,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          path,
          width: 28.w,
          height: 28.w,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      );
}

class _BannerSection extends StatelessWidget {
  const _BannerSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0),
          end: const Alignment(1, 1),
          colors: [
            AppColors.gold.withValues(alpha: 0.1),
            AppColors.gold.withValues(alpha: 0.05),
          ],
        ),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.2), width: 2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/icon_community.svg',
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(AppColors.gold, BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'onboarding.bannerTitle'.tr(),
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 8.h),
                Text(
                  'onboarding.bannerSubtitle'.tr(),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterActions extends StatelessWidget {
  const _FooterActions();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          text: 'onboarding.signup'.tr(),
          onPressed: () => context.go('/auth/signup'),
        ),
        SizedBox(height: 12.h),
        SecondaryButton(
          text: 'onboarding.login'.tr(),
          onPressed: () => context.go('/auth/login'),
        ),
        SizedBox(height: 12.h),
        Text(
          'onboarding.disclaimer'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
