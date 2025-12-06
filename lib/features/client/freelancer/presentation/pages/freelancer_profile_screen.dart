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
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/freelancer_portfolio_grid.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/review_card.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/reviews_summary_widget.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/widgets/service_card.dart';
import 'package:ehtirafy_app/features/client/freelancer/domain/entities/freelancer_entity.dart';

class FreelancerProfileScreen extends StatefulWidget {
  final String freelancerId;

  const FreelancerProfileScreen({super.key, required this.freelancerId});

  @override
  State<FreelancerProfileScreen> createState() =>
      _FreelancerProfileScreenState();
}

class _FreelancerProfileScreenState extends State<FreelancerProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  double _headerOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final newOpacity = (_scrollController.offset / 150).clamp(0.0, 1.0);
    if ((newOpacity - _headerOpacity).abs() > 0.01) {
      setState(() => _headerOpacity = newOpacity);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<FreelancerCubit>()..getFreelancerProfile(widget.freelancerId),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFFFAFAFA),
          body: BlocBuilder<FreelancerCubit, FreelancerState>(
            builder: (context, state) {
              if (state is FreelancerLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.gold),
                );
              } else if (state is FreelancerError) {
                return Center(child: Text(state.message));
              } else if (state is FreelancerLoaded) {
                return _buildProfileContent(context, state.freelancer);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    FreelancerEntity freelancer,
  ) {
    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverAppBar(
              pinned: true,
              expandedHeight: 260.h,
              backgroundColor: const Color(0xFF2B2B2B),
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: _buildBackButton(),
              title: AnimatedOpacity(
                opacity: _headerOpacity,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  freelancer.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Colors.white),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: _buildHeaderBackground(freelancer),
              ),
            ),

            // Profile Card
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: Offset(0, -50.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildEnhancedProfileCard(freelancer),
                ),
              ),
            ),

            // Tab Bar
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: Offset(0, -34.h),
                child: _buildTabBar(),
              ),
            ),

            // Tab Content
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: Offset(0, -18.h),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: _tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildPortfolioTab(freelancer),
                      _buildServicesTab(),
                      _buildReviewsTab(freelancer),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom padding
            SliverToBoxAdapter(child: SizedBox(height: 100.h)),
          ],
        ),

        // Sticky Bottom Button
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildBottomButton(context),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        margin: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildHeaderBackground(FreelancerEntity freelancer) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://picsum.photos/seed/profilebg/800/400',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Container(color: const Color(0xFF2B2B2B)),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.7),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 70.h,
          left: 20.w,
          right: 20.w,
          child: Row(
            children: [
              Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white, width: 3),
                  image: DecorationImage(
                    image: NetworkImage(freelancer.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            freelancer.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(Icons.verified, color: Colors.blue, size: 18.sp),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      freelancer.title,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14.sp,
                        fontFamily: 'Cairo',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedProfileCard(FreelancerEntity freelancer) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.star_rounded,
                AppColors.gold,
                freelancer.rating.toString(),
                '${freelancer.reviewsCount} ${AppStrings.freelancerProfileReviews.tr()}',
              ),
              _buildDivider(),
              _buildStatItem(
                Icons.work_outline_rounded,
                const Color(0xFF17A2B8),
                freelancer.projectsCount.toString(),
                AppStrings.freelancerProfileProjects.tr(),
              ),
              _buildDivider(),
              _buildStatItem(
                Icons.access_time_rounded,
                const Color(0xFF28A745),
                freelancer.responseTime,
                AppStrings.freelancerProfileResponse.tr(),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: const Color(0xFFF0F0F0), height: 1),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  freelancer.location,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textSecondary,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12.sp,
                      color: AppColors.gold,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${AppStrings.freelancerProfileMemberSince.tr()} ${freelancer.memberSince}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.gold,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            freelancer.bio,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary,
              height: 1.6,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    Color color,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2B2B2B),
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: AppColors.textSecondary,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 50.h, width: 1, color: const Color(0xFFF0F0F0));
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.gold,
        unselectedLabelColor: const Color(0xFF888888),
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Cairo',
        ),
        indicatorColor: AppColors.gold,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tabs: [
          Tab(text: AppStrings.freelancerProfilePortfolio.tr()),
          Tab(text: AppStrings.freelancerProfileServices.tr()),
          Tab(text: AppStrings.freelancerProfileReviews.tr()),
        ],
      ),
    );
  }

  Widget _buildPortfolioTab(FreelancerEntity freelancer) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      child: FreelancerPortfolioGrid(portfolio: freelancer.portfolio),
    );
  }

  Widget _buildServicesTab() {
    final services = AppMockData.mockFreelancerProfile['services'] as List;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: ServiceCard(
            title: service['title'],
            price: (service['price'] as num).toDouble(),
            description: service['description'],
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab(FreelancerEntity freelancer) {
    final reviews = AppMockData.mockFreelancerProfile['reviews'] as List;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      children: [
        ReviewsSummaryWidget(
          rating: freelancer.rating,
          reviewsCount: freelancer.reviewsCount,
          ratingDistribution: const {5: 0.8, 4: 0.15, 3: 0.05, 2: 0.0, 1: 0.0},
        ),
        SizedBox(height: 20.h),
        ...reviews.map(
          (review) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: ReviewCard(
              userName: review['userName'],
              userImage: review['userImage'],
              rating: (review['rating'] as num).toDouble(),
              date: review['date'],
              comment: review['comment'],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: BlocBuilder<FreelancerCubit, FreelancerState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                if (state is FreelancerLoaded) {
                  context.push(
                    '/booking/request',
                    extra: {
                      'freelancerId': widget.freelancerId,
                      'freelancerName': state.freelancer.name,
                      'serviceName': state.freelancer.title,
                      'price': 100.0,
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    AppStrings.freelancerProfileOrderNow.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
