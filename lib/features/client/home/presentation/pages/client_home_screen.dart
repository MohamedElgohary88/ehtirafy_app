import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/home_stats_section.dart';
import '../widgets/home_categories_section.dart';
import '../widgets/home_special_offer_banner.dart';
import '../widgets/home_featured_photographers.dart';
import '../widgets/home_sliver_header_delegate.dart';
import '../widgets/client_bottom_nav_bar.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.maybeOf(context)?.padding.top ?? 0.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: HomeSliverHeaderDelegate(topPadding: topPadding),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
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
          ],
        ),
        bottomNavigationBar: const ClientBottomNavBar(),
      ),
    );
  }
}
