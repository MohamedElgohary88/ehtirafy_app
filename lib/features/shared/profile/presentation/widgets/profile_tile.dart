import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: isDestructive ? 2 : 1,
              color: isDestructive
                  ? const Color(0xFFDC3545)
                  : const Color(0xFFE5E5E5),
            ),
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: isDestructive
                      ? const Color(0xFFDC3545)
                      : const Color(0xFF2B2B2B),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    color: isDestructive
                        ? const Color(0xFFDC3545)
                        : const Color(0xFF2B2B2B),
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isDestructive
                  ? const Color(0xFFDC3545)
                  : const Color(0xFF2B2B2B),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
