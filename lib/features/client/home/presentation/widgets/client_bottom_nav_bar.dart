import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';

class ClientBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ClientBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => onTap(0),
            behavior: HitTestBehavior.opaque,
            child: _NavBarItem(
              icon: Icons.person_outline,
              label: 'حسابي',
              isSelected: currentIndex == 0,
            ),
          ),
          GestureDetector(
            onTap: () => onTap(1),
            behavior: HitTestBehavior.opaque,
            child: _NavBarItem(
              icon: Icons.chat_bubble_outline,
              label: 'الرسائل',
              isSelected: currentIndex == 1,
            ),
          ),
          GestureDetector(
            onTap: () => onTap(2),
            behavior: HitTestBehavior.opaque,
            child: _NavBarItem(
              icon: Icons.list_alt,
              label: 'طلباتي',
              isSelected: currentIndex == 2,
            ),
          ),
          GestureDetector(
            onTap: () => onTap(3),
            behavior: HitTestBehavior.opaque,
            child: _NavBarItem(
              icon: Icons.home_filled,
              label: 'الرئيسية',
              isSelected: currentIndex == 3,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.gold : const Color(0xFF888888);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
