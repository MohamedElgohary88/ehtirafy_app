import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ehtirafy_app/features/client/home/domain/entities/category_entity.dart';

class HomeCategoriesSection extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String locale;

  const HomeCategoriesSection({
    super.key,
    required this.categories,
    this.locale = 'ar',
  });

  // Emoji mapping based on category name
  String _getCategoryEmoji(String nameEn) {
    final lower = nameEn.toLowerCase();
    if (lower.contains('party') ||
        lower.contains('parties') ||
        lower.contains('event')) {
      return '🎉';
    } else if (lower.contains('wedding') || lower.contains('marriage')) {
      return '💍';
    } else if (lower.contains('food') || lower.contains('restaurant')) {
      return '🍽️';
    } else if (lower.contains('real estate') ||
        lower.contains('property') ||
        lower.contains('house')) {
      return '🏠';
    } else if (lower.contains('product')) {
      return '📦';
    } else if (lower.contains('portrait') || lower.contains('session')) {
      return '📸';
    } else if (lower.contains('organiz')) {
      return '🎉';
    }
    return '📷'; // Default camera emoji
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            'الفئات',
            style: TextStyle(
              color: const Color(0xFF2B2B2B),
              fontSize: 16.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        if (categories.isEmpty)
          _buildEmptyState()
        else
          SizedBox(
            height: 140.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              itemCount: categories.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final category = categories[index];
                return _CategoryCard(
                  emoji: _getCategoryEmoji(category.nameEn),
                  title: category.getLocalizedName(locale),
                  categoryId: category.id,
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 140.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              size: 32.sp,
              color: const Color(0xFF888888),
            ),
            SizedBox(height: 8.h),
            Text(
              'لا توجد فئات متاحة',
              style: TextStyle(
                color: const Color(0xFF888888),
                fontSize: 14.sp,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String emoji;
  final String title;
  final int categoryId;

  const _CategoryCard({
    required this.emoji,
    required this.title,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to category screen with categoryId
      },
      child: Container(
        width: 130.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: TextStyle(fontSize: 30.sp)),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF2B2B2B),
                fontSize: 14.sp,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
