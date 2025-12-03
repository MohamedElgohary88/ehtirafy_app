import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/cubits/freelancer_cubit.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/cubits/freelancer_state.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/custom_segmented_tab_bar.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/freelancer_portfolio_grid.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/profile_info_card.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/review_card.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/reviews_summary_widget.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/service_card.dart';

class FreelancerProfileScreen extends StatefulWidget {
  final String freelancerId;

  const FreelancerProfileScreen({super.key, required this.freelancerId});

  @override
  State<FreelancerProfileScreen> createState() =>
      _FreelancerProfileScreenState();
}

class _FreelancerProfileScreenState extends State<FreelancerProfileScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<FreelancerCubit>()..getFreelancerProfile(widget.freelancerId),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    final state = context.read<FreelancerCubit>().state;
                    if (state is FreelancerLoaded) {
                      context.push(
                        '/booking/request',
                        extra: {
                          'freelancerId': widget.freelancerId,
                          'freelancerName': state.freelancer.name,
                          'serviceName': state.freelancer.title,
                          'price':
                              100.0, // TODO: Get actual price from service selection
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.freelancerProfileOrderNow.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        body: BlocBuilder<FreelancerCubit, FreelancerState>(
          builder: (context, state) {
            if (state is FreelancerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FreelancerError) {
              return Center(child: Text(state.message));
            } else if (state is FreelancerLoaded) {
              final freelancer = state.freelancer;
              return CustomScrollView(
                slivers: [
                  // 1. Sticky Header
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 220.h,
                    backgroundColor: const Color(0xFF2B2B2B),
                    elevation:
                        0, // CRITICAL: Removes shadow/elevation to allow overlap
                    scrolledUnderElevation:
                        0, // CRITICAL: Prevents elevation change on scroll
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text(
                      AppStrings.freelancerProfileTitle.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            'https://placehold.co/800x400/2B2B2B/FFFFFF/png?text=Wood+Texture',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 2. Profile Card (Overlapping)
                  // SliverToBoxAdapter paints AFTER SliverAppBar, so it should be ON TOP.
                  // We use Transform to pull it up.
                  SliverToBoxAdapter(
                    child: Transform.translate(
                      offset: Offset(0, -50.h),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: ProfileInfoCard(freelancer: freelancer),
                      ),
                    ),
                  ),

                  // 3. Tabs
                  SliverToBoxAdapter(
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        -34.h,
                      ), // Adjust for the card overlap spacing
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: CustomSegmentedTabBar(
                          selectedIndex: _selectedIndex,
                          onTabSelected: (index) =>
                              setState(() => _selectedIndex = index),
                        ),
                      ),
                    ),
                  ),

                  // 4. Content
                  SliverToBoxAdapter(
                    child: Transform.translate(
                      offset: Offset(0, -18.h), // Adjust for spacing
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: IndexedStack(
                          index: _selectedIndex,
                          children: [
                            FreelancerPortfolioGrid(
                              portfolio: freelancer.portfolio,
                            ),
                            Column(
                              children:
                                  (AppMockData.mockFreelancerProfile['services']
                                          as List)
                                      .map(
                                        (service) => ServiceCard(
                                          title: service['title'],
                                          price: (service['price'] as num)
                                              .toDouble(),
                                          description: service['description'],
                                        ),
                                      )
                                      .toList(),
                            ),
                            Column(
                              children: [
                                ReviewsSummaryWidget(
                                  rating: freelancer.rating,
                                  reviewsCount: freelancer.reviewsCount,
                                  ratingDistribution: const {
                                    5: 0.8,
                                    4: 0.15,
                                    3: 0.05,
                                    2: 0.0,
                                    1: 0.0,
                                  },
                                ),
                                SizedBox(height: 24.h),
                                ...(AppMockData.mockFreelancerProfile['reviews']
                                        as List)
                                    .map(
                                      (review) => ReviewCard(
                                        userName: review['userName'],
                                        userImage: review['userImage'],
                                        rating: (review['rating'] as num)
                                            .toDouble(),
                                        date: review['date'],
                                        comment: review['comment'],
                                      ),
                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom Padding for Sticky Button
                  SliverToBoxAdapter(child: SizedBox(height: 100.h)),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
