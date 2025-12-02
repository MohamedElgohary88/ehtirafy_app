import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/cubits/freelancer_cubit.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/cubits/freelancer_state.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/freelancer_portfolio_grid.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/profile_info_card.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/review_card.dart';
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
            child: ElevatedButton(
              onPressed: () {},
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Item 1: The Header Stack
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        // Layer 1: Background Header
                        Container(
                          height: 200.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2B2B2B),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://placehold.co/800x400/2B2B2B/FFFFFF/png?text=Wood+Texture',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                            ),
                            child: SafeArea(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Text(
                                        AppStrings.freelancerProfileTitle.tr(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Layer 2: The Floating Card
                        Container(
                          margin: EdgeInsets.only(
                            top: 150.h,
                            left: 20.w,
                            right: 20.w,
                          ),
                          child: ProfileInfoCard(freelancer: freelancer),
                        ),
                      ],
                    ),

                    // Item 2: Spacer (Already handled by Container margin in Stack, but adding safe spacing below)
                    SizedBox(height: 24.h),

                    // Item 3: The Tabs Section
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.grey200,
                            width: 1.h,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildTabItem(
                            0,
                            AppStrings.freelancerProfilePortfolio.tr(),
                          ),
                          _buildTabItem(
                            1,
                            AppStrings.freelancerProfileServices.tr(),
                          ),
                          _buildTabItem(
                            2,
                            AppStrings.freelancerProfileReviews.tr(),
                          ),
                        ],
                      ),
                    ),

                    // Item 4: The Tab Content
                    Container(
                      padding: EdgeInsets.all(24.w),
                      child: _buildTabContent(_selectedIndex, freelancer),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: isSelected
                ? Border(
                    bottom: BorderSide(color: AppColors.gold, width: 2.h),
                  )
                : null,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.gold : const Color(0xFF888888),
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(int index, dynamic freelancer) {
    switch (index) {
      case 0:
        return FreelancerPortfolioGrid(portfolio: freelancer.portfolio);
      case 1:
        return Column(
          children: (AppMockData.mockFreelancerProfile['services'] as List)
              .map(
                (service) => ServiceCard(
                  title: service['title'],
                  price: (service['price'] as num).toDouble(),
                  description: service['description'],
                ),
              )
              .toList(),
        );
      case 2:
        return Column(
          children: (AppMockData.mockFreelancerProfile['reviews'] as List)
              .map(
                (review) => ReviewCard(
                  userName: review['userName'],
                  userImage: review['userImage'],
                  rating: (review['rating'] as num).toDouble(),
                  date: review['date'],
                  comment: review['comment'],
                ),
              )
              .toList(),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
