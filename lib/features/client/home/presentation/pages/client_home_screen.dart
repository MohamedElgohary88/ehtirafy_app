import 'package:flutter/material.dart';
import '../widgets/home_stats_section.dart';
import '../widgets/home_categories_section.dart';
import '../widgets/home_special_offer_banner.dart';
import '../widgets/home_featured_photographers.dart';
import '../widgets/home_header_section.dart';
import '../widgets/client_bottom_nav_bar.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HomeHeaderSection(),
            SizedBox(height: 24),
            HomeStatsSection(),
            SizedBox(height: 24),
            HomeCategoriesSection(),
            SizedBox(height: 24),
            HomeSpecialOfferBanner(),
            SizedBox(height: 24),
            HomeFeaturedPhotographers(),
            SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const ClientBottomNavBar(),
    );
  }
}
