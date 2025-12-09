import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import '../cubit/freelancer_dashboard_cubit.dart';
import '../cubit/freelancer_dashboard_state.dart';
import '../widgets/stat_card.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/entities/portfolio_item_entity.dart';
import '../../domain/entities/freelancer_order_entity.dart';

class FreelancerDashboardScreen extends StatefulWidget {
  const FreelancerDashboardScreen({super.key});

  @override
  State<FreelancerDashboardScreen> createState() =>
      _FreelancerDashboardScreenState();
}

class _FreelancerDashboardScreenState extends State<FreelancerDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FreelancerDashboardCubit>().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: Column(
          children: [
            _buildDarkHeader(context),
            Expanded(
              child:
                  BlocBuilder<
                    FreelancerDashboardCubit,
                    FreelancerDashboardState
                  >(
                    builder: (context, state) {
                      if (state is FreelancerDashboardLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is FreelancerDashboardError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.message),
                              SizedBox(height: 16.h),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<FreelancerDashboardCubit>()
                                    .loadDashboard(),
                                child: const Text('إعادة المحاولة'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is FreelancerDashboardLoaded) {
                        return RefreshIndicator(
                          onRefresh: () => context
                              .read<FreelancerDashboardCubit>()
                              .loadDashboard(),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16.h),
                                _buildHeader(context, state),
                                SizedBox(height: 24.h),
                                _buildStatsSection(context, state),
                                SizedBox(height: 24.h),
                                _buildPortfolioSection(
                                  context,
                                  state.portfolioItems,
                                ),
                                SizedBox(height: 24.h),
                                _buildGigsSection(context, state.gigs),
                                SizedBox(height: 24.h),
                                _buildRecentOrdersSection(
                                  context,
                                  state.recentOrders,
                                ),
                                SizedBox(height: 32.h),
                              ],
                            ),
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkHeader(BuildContext context) {
    return Container(
      color: AppColors.dark,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: const BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Center(
            child: Text(
              AppStrings.navDashboard.tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, FreelancerDashboardLoaded state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppStrings.freelancerDashboardWelcome.tr()}،',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF888888),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Text(
                  state.userName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF2B2B2B),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Row(
                  children: [
                    Icon(Icons.star, color: AppColors.primary, size: 16.sp),
                    SizedBox(width: 2.w),
                    Text(
                      '${state.stats.rating}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF2B2B2B),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Online toggle
        _buildOnlineToggle(context, state),
      ],
    );
  }

  Widget _buildOnlineToggle(
    BuildContext context,
    FreelancerDashboardLoaded state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: state.stats.isOnline
            ? const Color(0xFF28A745).withOpacity(0.1)
            : const Color(0xFF888888).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: state.stats.isOnline
              ? const Color(0xFF28A745).withOpacity(0.3)
              : const Color(0xFF888888).withOpacity(0.3),
        ),
      ),
      child: InkWell(
        onTap: () {
          context.read<FreelancerDashboardCubit>().toggleOnlineStatus(
            !state.stats.isOnline,
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: state.stats.isOnline
                    ? const Color(0xFF28A745)
                    : const Color(0xFF888888),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              state.stats.isOnline
                  ? AppStrings.freelancerDashboardOnline.tr()
                  : AppStrings.freelancerDashboardOffline.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: state.stats.isOnline
                    ? const Color(0xFF28A745)
                    : const Color(0xFF888888),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(
    BuildContext context,
    FreelancerDashboardLoaded state,
  ) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            title: AppStrings.freelancerDashboardTotalEarnings.tr(),
            value: '${state.stats.totalEarnings.toInt()} ر.س',
            icon: Icons.account_balance_wallet_outlined,
            iconColor: AppColors.primary,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: StatCard(
            title: AppStrings.freelancerDashboardActiveOrders.tr(),
            value: '${state.stats.activeOrders}',
            icon: Icons.assignment_outlined,
            iconColor: const Color(0xFF28A745),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: StatCard(
            title: AppStrings.freelancerDashboardProfileViews.tr(),
            value: '${state.stats.profileViews}',
            icon: Icons.visibility_outlined,
            iconColor: const Color(0xFF17A2B8),
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioSection(
    BuildContext context,
    List<PortfolioItemEntity> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          AppStrings.freelancerDashboardPortfolioSection.tr(),
          AppStrings.freelancerDashboardManagePortfolio.tr(),
          () => context.push('/freelancer/portfolio'),
        ),
        SizedBox(height: 12.h),
        if (items.isEmpty)
          _buildEmptyPortfolioCard(context)
        else
          SizedBox(
            height: 120.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildPortfolioItem(context, item);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildPortfolioItem(BuildContext context, PortfolioItemEntity item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.network(
        item.image ?? '',
        width: 120.w,
        height: 120.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 120.w,
          height: 120.h,
          color: const Color(0xFFF5F5F5),
          child: Icon(Icons.image, color: Colors.grey, size: 32.sp),
        ),
      ),
    );
  }

  Widget _buildEmptyPortfolioCard(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/freelancer/portfolio/add'),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 48.sp,
              color: AppColors.primary,
            ),
            SizedBox(height: 12.h),
            Text(
              AppStrings.freelancerDashboardEmptyPortfolio.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF2B2B2B),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              AppStrings.freelancerDashboardAddFirstWork.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF888888),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGigsSection(BuildContext context, List<GigEntity> gigs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          AppStrings.freelancerDashboardServicesSection.tr(),
          AppStrings.freelancerDashboardAddService.tr(),
          () => context.push('/freelancer/gigs/create'),
          onTitleTap: () => context.push('/freelancer/gigs'),
        ),
        SizedBox(height: 12.h),
        if (gigs.isEmpty)
          _buildEmptyGigsCard(context)
        else
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: gigs.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final gig = gigs[index];
                return _buildGigPreviewCard(context, gig);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildGigPreviewCard(BuildContext context, GigEntity gig) {
    return Container(
      width: 200.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              gig.coverImage,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60.w,
                height: 60.h,
                color: const Color(0xFFF5F5F5),
                child: Icon(Icons.camera_alt, size: 20.sp, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  gig.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF2B2B2B),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${gig.price.toInt()} ريال',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyGigsCard(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/freelancer/gigs/create'),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              Icons.add_business_outlined,
              size: 48.sp,
              color: AppColors.primary,
            ),
            SizedBox(height: 12.h),
            Text(
              AppStrings.freelancerDashboardEmptyServices.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF2B2B2B),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrdersSection(
    BuildContext context,
    List<FreelancerOrderEntity> orders,
  ) {
    if (orders.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          AppStrings.freelancerDashboardRecentRequests.tr(),
          AppStrings.freelancerDashboardViewAll.tr(),
          () {
            // Navigate to orders tab (index 2)
          },
        ),
        SizedBox(height: 12.h),
        ...orders.map(
          (order) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildOrderPreviewCard(context, order),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderPreviewCard(
    BuildContext context,
    FreelancerOrderEntity order,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: const Color(0xFFF5F5F5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                order.clientImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.person, size: 20.sp, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.serviceTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF2B2B2B),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  order.clientName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF888888),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${order.price.toInt()} ر.س',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    String actionText,
    VoidCallback onAction, {
    VoidCallback? onTitleTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTitleTap,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF2B2B2B),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: onAction,
          child: Text(
            actionText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
