import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../manager/profile_cubit.dart';

class RoleSwitcherCard extends StatelessWidget {
  final UserRole currentRole;

  const RoleSwitcherCard({super.key, required this.currentRole});

  @override
  Widget build(BuildContext context) {
    final isClient = currentRole == UserRole.client;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.00, 0.00),
          end: const Alignment(1.00, 1.00),
          colors: [const Color(0x19C8A34E), Colors.black.withValues(alpha: 0)],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFFC8A44F)),
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Role Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF17A2B8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    isClient
                        ? 'profile.role_client'.tr()
                        : 'profile.role_freelancer'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Browsing As Text
                Row(
                  children: [
                    Text(
                      'profile.browsing_as'.tr(),
                      style: TextStyle(
                        color: const Color(0xFF888888),
                        fontSize: 12.sp,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      isClient
                          ? 'profile.role_client'.tr()
                          : 'profile.role_freelancer'.tr(),
                      style: TextStyle(
                        color: const Color(0xFF2B2B2B),
                        fontSize: 16.sp,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                // Icon
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: ShapeDecoration(
                    color: const Color(0x33C8A34E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Icon(
                    isClient ? Icons.person_outline : Icons.camera_alt_outlined,
                    color: const Color(0xFFC8A44F),
                    size: 20.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Switch Button
            InkWell(
              onTap: () {
                context.read<ProfileCubit>().toggleRole();
              },
              child: Container(
                width: double.infinity,
                height: 44.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFFC8A44F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    isClient
                        ? 'profile.switch_to_freelancer'.tr()
                        : 'profile.switch_to_client'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
