import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  final double size; // logical size reference (pre-scale)
  final String assetPath;

  const AppLogo({super.key, this.size = 120, this.assetPath = 'assets/images/logo.png'});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
      height: size.w,
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}

