import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/core/widgets/primary_button.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/widgets/auth_header.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/widgets/auth_text_field.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/cubits/login_cubit.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

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
              children: [
                AuthHeader(
                  iconAsset: 'assets/icons/camera_icon.svg',
                  title: 'auth.welcomeBack'.tr(),
                  subtitle: 'auth.loginSubtitle'.tr(),
                ),
                SizedBox(height: 24.h),
                _LoginForm(),
                SizedBox(height: 24.h),
                _SocialDivider(),
                SizedBox(height: 12.h),
                _SocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.go('/home');
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failureKey.tr())),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        final theme = Theme.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTextField(
              label: 'auth.emailLabel'.tr(),
              hint: 'auth.emailHint'.tr(),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16.h),
            AuthTextField(
              label: 'auth.passwordLabel'.tr(),
              hint: 'auth.passwordHint'.tr(),
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'auth.forgotPassword'.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(color: AppColors.gold),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            PrimaryButton(
              text: 'auth.loginButton'.tr(),
              onPressed: () {
                final currentState = context.read<LoginCubit>().state;
                if (currentState is LoginLoading) return;
                cubit.login(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              },
              isLoading: state is LoginLoading,
            ),
            SizedBox(height: 16.h),
            // Inline text with clickable trailing action (no extra spacing)
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'auth.noAccount'.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                    TextSpan(
                      text: 'auth.createAccount'.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.gold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go('/auth/signup'),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SocialDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.grey300, thickness: 1.h)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text('auth.or'.tr(), style: theme.textTheme.bodySmall?.copyWith(color: AppColors.grey600)),
        ),
        Expanded(child: Divider(color: AppColors.grey300, thickness: 1.h)),
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _OutlinedIconButton(
          iconAsset: 'assets/icons/google.svg',
          label: 'auth.loginGoogle'.tr(),
          onPressed: () {},
        ),
        SizedBox(height: 12.h),
        _OutlinedIconButton(
          iconAsset: 'assets/icons/apple.svg',
          label: 'auth.loginApple'.tr(),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _OutlinedIconButton extends StatelessWidget {
  final String iconAsset;
  final String label;
  final VoidCallback onPressed;

  const _OutlinedIconButton({
    required this.iconAsset,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.grey300, width: 2.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconAsset, width: 16.w, height: 16.w),
            SizedBox(width: 12.w),
            Text(label, style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
