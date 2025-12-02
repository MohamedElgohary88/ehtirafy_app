import 'package:flutter/material.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'الفئات',
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: const [
              _CategoryCard(
                emoji: '🏠',
                title: 'تصوير عقارات',
                count: '64 مصور',
              ),
              SizedBox(width: 12),
              _CategoryCard(
                emoji: '🍽️',
                title: 'تصوير طعام',
                count: '87 مصور',
              ),
              SizedBox(width: 12),
              _CategoryCard(
                emoji: '🎉',
                title: 'تصوير مناسبات',
                count: '176 مصور',
              ),
              SizedBox(width: 12),
              _CategoryCard(
                emoji: '📸',
                title: 'جلسات تصوير',
                count: '203 مصور',
              ),
              SizedBox(width: 12),
              _CategoryCard(
                emoji: '📦',
                title: 'تصوير منتجات',
                count: '98 مصور',
              ),
              SizedBox(width: 12),
              _CategoryCard(
                emoji: '💍',
                title: 'تصوير أفراح',
                count: '150 مصور',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String count;

  const _CategoryCard({
    required this.emoji,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 14,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            count,
            style: const TextStyle(
              color: Color(0xFF888888),
              fontSize: 12,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
