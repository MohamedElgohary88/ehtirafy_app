import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/primary_button.dart';

/// Onboarding Screen with PageView and 3 feature cards
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      iconPath: 'assets/icons/icon_photographers.svg',
      title: 'Find Top Photographers',
      description:
          'Connect with skilled professionals for all your photography needs',
    ),
    OnboardingData(
      iconPath: 'assets/icons/icon_quality.svg',
      title: 'Quality Services',
      description: 'Get access to premium photography services at competitive prices',
    ),
    OnboardingData(
      iconPath: 'assets/icons/icon_community.svg',
      title: 'Join Our Community',
      description:
          'Be part of a growing community of photographers and clients',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: false, // Disable back button
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                // PageView with Feature Cards
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      return _OnboardingCard(
                        data: _onboardingData[index],
                      );
                    },
                  ),
                ),

                // Dot Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => _DotIndicator(
                      isActive: _currentPage == index,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),

                // Get Started Button
                PrimaryButton(
                  text: 'Get Started',
                  onPressed: () => context.go(AppRoutes.login),
                ),
                SizedBox(height: 16.h),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: OutlinedButton(
                    onPressed: () => context.go(AppRoutes.signup),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.gold, width: 1.5.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Create Account',
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Onboarding data model
class OnboardingData {
  final String iconPath;
  final String title;
  final String description;

  const OnboardingData({
    required this.iconPath,
    required this.title,
    required this.description,
  });
}

/// Onboarding Card Widget
class _OnboardingCard extends StatelessWidget {
  final OnboardingData data;

  const _OnboardingCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon Container
        Container(
          width: 150.w,
          height: 150.w,
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              data.iconPath,
              width: 80.w,
              height: 80.w,
              colorFilter: const ColorFilter.mode(
                AppColors.gold,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        SizedBox(height: 40.h),

        // Title
        Text(
          data.title,
          style: GoogleFonts.cairo(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textLight : AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),

        // Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            data.description,
            style: GoogleFonts.cairo(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: isDark ? AppColors.grey400 : AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

/// Dot Indicator Widget
class _DotIndicator extends StatelessWidget {
  final bool isActive;

  const _DotIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 24.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: isActive ? AppColors.gold : AppColors.grey300,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
