import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ehtirafy_app/core/widgets/app_logo.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

/// Flutter Splash Screen - Shown after native splash
///
/// This screen appears after the native splash and provides:
/// - App logo centered
/// - Tagline at the bottom
/// - 2-3 second delay before navigating to onboarding
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Use context.go() to replace the splash route (no back navigation)
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: isDarkMode ? AppColors.dark : AppColors.backgroundLight,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo - centered
              const AppLogo(
                width: 145,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              // Tagline - at bottom
              Padding(
                padding: EdgeInsets.only(bottom: 80.h),
                child: Text(
                  'splash.tagline'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? AppColors.grey400
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
