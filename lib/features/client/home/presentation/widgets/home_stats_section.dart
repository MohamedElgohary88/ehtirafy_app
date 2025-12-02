import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';

class HomeStatsSection extends StatelessWidget {
  const HomeStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: const [
          _StatCard(
            label: 'مشروع',
            value: '2.5K+',
            icon: Icons.work_outline, // Placeholder icon
          ),
          SizedBox(width: 12),
          _StatCard(
            label: 'تقييم',
            value: '4.8+',
            icon: Icons.star_border, // Placeholder icon
          ),
          SizedBox(width: 12),
          _StatCard(
            label: 'مصور',
            value: '+500',
            icon: Icons.camera_alt_outlined, // Placeholder icon
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.gold, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: 'Cairo',
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF888888),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
