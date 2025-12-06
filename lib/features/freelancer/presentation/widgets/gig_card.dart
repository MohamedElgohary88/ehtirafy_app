import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import '../../domain/entities/gig_entity.dart';

class GigCard extends StatelessWidget {
  final GigEntity gig;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const GigCard({
    super.key,
    required this.gig,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0D000000),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: const Color(0xFFF2F2F2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                gig.coverImage,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80.w,
                  height: 80.h,
                  color: const Color(0xFFF5F5F5),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          gig.title,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: const Color(0xFF2B2B2B),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildStatusBadge(context),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    gig.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF888888),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_buildPrice(context), _buildActions(context)],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    Color backgroundColor;
    String text;

    switch (gig.status) {
      case GigStatus.active:
        backgroundColor = const Color(0xFF28A745);
        text = 'نشط';
        break;
      case GigStatus.pending:
        backgroundColor = const Color(0xFF17A2B8);
        text = 'قيد المراجعة';
        break;
      case GigStatus.inactive:
        backgroundColor = const Color(0xFF6C757D);
        text = 'غير نشط';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Row(
      children: [
        Text(
          '${gig.price.toInt()}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.primary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          'ريال',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF888888),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        if (onEdit != null)
          IconButton(
            onPressed: onEdit,
            icon: Icon(Icons.edit_outlined, size: 18.sp),
            color: const Color(0xFF888888),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
          ),
        if (onDelete != null)
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline, size: 18.sp),
            color: const Color(0xFFDC3545),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
          ),
      ],
    );
  }
}
