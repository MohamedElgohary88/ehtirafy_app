import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';

class HomeFeaturedPhotographers extends StatelessWidget {
  const HomeFeaturedPhotographers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'أبرز المصورين',
                style: TextStyle(
                  color: Color(0xFF2B2B2B),
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return const _PhotographerCard();
          },
        ),
      ],
    );
  }
}

class _PhotographerCard extends StatelessWidget {
  const _PhotographerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage("https://placehold.co/80x80.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'أحمد المصور',
                      style: TextStyle(
                        color: Color(0xFF2B2B2B),
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      Icons.bookmark_border,
                      color: AppColors.gold,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'تصوير حفلات زفاف',
                  style: TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.gold, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      '4.9',
                      style: TextStyle(
                        color: Color(0xFF2B2B2B),
                        fontSize: 14,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '(127)',
                      style: TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 14,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF888888),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'الرياض',
                      style: TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 14,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'عرض الملف',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Row(
                      children: [
                        Text(
                          '5,000',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 16,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'ريال',
                          style: TextStyle(
                            color: Color(0xFF888888),
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
