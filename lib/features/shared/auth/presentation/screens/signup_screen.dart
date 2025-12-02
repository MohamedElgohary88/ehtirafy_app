import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/core/widgets/primary_button.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/widgets/auth_header.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/widgets/auth_text_field.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/cubits/signup_cubit.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/cubits/signup_state.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignupCubit>(),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatelessWidget {
  const _SignupView();

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
                  title: AppStrings.authSignupTitle.tr(),
                  subtitle: AppStrings.authSignupSubtitle.tr(),
                ),
                SizedBox(height: 24.h),
                const _SignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignupForm extends StatefulWidget {
  const _SignupForm();

  @override
  State<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          context.go(
            '/auth/otp?phone=${Uri.encodeComponent(_phoneController.text)}',
          );
        } else if (state is SignupError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.failureKey.tr())));
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignupCubit>();
        final theme = Theme.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTextField(
              label: AppStrings.authFullNameLabel.tr(),
              hint: AppStrings.authFullNameHint.tr(),
              controller: _fullNameController,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16.h),
            AuthTextField(
              label: AppStrings.authEmailLabel.tr(),
              hint: AppStrings.authEmailHint.tr(),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16.h),
            AuthTextField(
              label: AppStrings.authPhoneLabel.tr(),
              hint: AppStrings.authPhoneHint.tr(),
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16.h),
            AuthTextField(
              label: AppStrings.authPasswordLabel.tr(),
              hint: AppStrings.authPasswordHint.tr(),
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.authPasswordRequirements.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.grey600,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            PrimaryButton(
              text: AppStrings.authSignupButton.tr(),
              onPressed: () {
                final current = context.read<SignupCubit>().state;
                if (current is SignupLoading) return;
                cubit.signup(
                  fullName: _fullNameController.text.trim(),
                  email: _emailController.text.trim(),
                  phone: _phoneController.text.trim(),
                  password: _passwordController.text.trim(),
                );
              },
              isLoading: state is SignupLoading,
            ),
            SizedBox(height: 16.h),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppStrings.authHaveAccount.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                    TextSpan(
                      text: AppStrings.authLoginNow.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.gold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go('/auth/login'),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppStrings.authTermsPrefix.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                    TextSpan(
                      text: AppStrings.authTerms.tr(),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.gold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: AppStrings.authAnd.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                    TextSpan(
                      text: AppStrings.authPrivacy.tr(),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.gold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
