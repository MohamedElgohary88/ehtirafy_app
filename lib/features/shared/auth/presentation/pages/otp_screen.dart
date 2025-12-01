import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/primary_button.dart';

/// OTP Verification Screen
/// 4-digit Pinput with 58-second countdown timer
class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isLoading = false;
  bool _canResend = false;
  int _remainingSeconds = 58;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _remainingSeconds = 58;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        setState(() => _canResend = true);
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _handleVerify() async {
    if (_otpController.text.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter 4-digit code')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRoutes.roleSelection);
    }
  }

  Future<void> _handleResend() async {
    if (!_canResend) return;

    // TODO: Implement resend OTP API call
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP resent successfully')),
    );

    _startTimer();
  }

  String _formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pinput theme
    final defaultPinTheme = PinTheme(
      width: 64.w,
      height: 64.h,
      textStyle: GoogleFonts.cairo(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textLight : AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.grey800 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.grey700 : AppColors.grey300,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: isDark ? AppColors.grey800 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.gold,
          width: 2,
        ),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: isDark ? AppColors.grey800 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.gold,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? AppColors.textLight : AppColors.textPrimary,
          ),
          onPressed: () => context.go(AppRoutes.signup),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // Header
              Text(
                'Verification',
                style: GoogleFonts.cairo(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'We sent a verification code to',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  color: isDark ? AppColors.grey400 : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.phoneNumber.isNotEmpty
                    ? widget.phoneNumber
                    : 'your phone number',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gold,
                ),
              ),
              SizedBox(height: 40.h),

              // OTP Input (Pinput)
              Center(
                child: Pinput(
                  controller: _otpController,
                  focusNode: _focusNode,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  showCursor: true,
                  cursor: Container(
                    width: 2.w,
                    height: 24.h,
                    color: AppColors.gold,
                  ),
                  onCompleted: (pin) {
                    // Auto-submit when 4 digits entered
                    _handleVerify();
                  },
                ),
              ),
              SizedBox(height: 32.h),

              // Timer and Resend
              Center(
                child: Column(
                  children: [
                    // Timer
                    if (!_canResend)
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            color: isDark
                                ? AppColors.grey400
                                : AppColors.textSecondary,
                          ),
                          children: [
                            const TextSpan(text: 'Resend code in '),
                            TextSpan(
                              text: _formatTime(_remainingSeconds),
                              style: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.gold,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Resend Button
                    if (_canResend)
                      TextButton(
                        onPressed: _handleResend,
                        child: Text(
                          'Resend Code',
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const Spacer(),

              // Verify Button
              PrimaryButton(
                text: 'Verify',
                onPressed: _handleVerify,
                isLoading: _isLoading,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}