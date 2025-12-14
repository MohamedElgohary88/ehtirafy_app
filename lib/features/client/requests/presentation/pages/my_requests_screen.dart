import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';
import 'package:ehtirafy_app/features/client/contract/data/datasources/contract_remote_data_source.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/cubits/role_cubit.dart';
import 'package:ehtirafy_app/features/shared/auth/domain/entities/user_role.dart'
    as auth_role;
import 'package:ehtirafy_app/features/shared/profile/domain/entities/user_role.dart';
import '../../data/repositories/requests_repository_impl.dart';
import '../../domain/usecases/get_my_requests_usecase.dart';
import '../cubit/requests_cubit.dart';
import '../cubit/requests_state.dart';
import '../../../booking/presentation/widgets/request_card.dart';
import '../widgets/requests_filter_tab.dart';

/// My Requests Screen - Shows contracts for both clients and freelancers
///
/// 3 Tabs:
/// - Tab 0: Active (accepted, payment required)
/// - Tab 1: Under Review (pending)
/// - Tab 2: Completed (completed/cancelled)
class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current user role to determine which contracts to fetch
    // Use the RoleCubit's selected getter directly (always has current role)
    final roleCubit = sl<RoleCubit>();
    final authRole = roleCubit.selected;

    // Debug log
    debugPrint('🔍 MyRequestsScreen - authRole from RoleCubit: $authRole');

    // Map from auth.UserRole to profile.UserRole
    UserRole currentRole = authRole == auth_role.UserRole.freelancer
        ? UserRole.freelancer
        : UserRole.client;

    debugPrint('🔍 MyRequestsScreen - mapped currentRole: $currentRole');

    return BlocProvider(
      create: (context) => RequestsCubit(
        GetMyRequestsUseCase(
          RequestsRepositoryImpl(
            remoteDataSource: sl<ContractRemoteDataSource>(),
            userRole: currentRole,
          ),
        ),
      )..getRequests(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          body: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: BlocBuilder<RequestsCubit, RequestsState>(
                  builder: (context, state) {
                    if (state is RequestsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RequestsError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48.sp,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () {
                                context.read<RequestsCubit>().getRequests();
                              },
                              child: Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      );
                    } else if (state is RequestsLoaded) {
                      return Column(
                        children: [
                          SizedBox(height: 24.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: RequestsFilterTab(
                              selectedIndex: state.selectedTabIndex,
                              onTabSelected: (index) {
                                context.read<RequestsCubit>().changeTab(index);
                              },
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: state.filteredRequests.isEmpty
                                  ? _buildEmptyState(context)
                                  : ListView.separated(
                                      key: ValueKey<int>(
                                        state.selectedTabIndex,
                                      ),
                                      padding: EdgeInsets.only(
                                        left: 24.w,
                                        right: 24.w,
                                        bottom: 24.h,
                                      ),
                                      itemCount: state.filteredRequests.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 16.h),
                                      itemBuilder: (context, index) {
                                        return RequestCard(
                                          request:
                                              state.filteredRequests[index],
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
              AppStrings.myRequestsTitle.tr(),
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

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: 349.w,
      height: 268.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFF9F9F9),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Color(0xFFE5E5E5)),
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 40.sp,
              color: const Color(0xFF888888),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            AppStrings.myRequestsNoRequests.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF2B2B2B),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppStrings.myRequestsStartRequesting.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF888888),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              // Navigate to home or photographers list
              context.go('/home');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: ShapeDecoration(
                color: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                AppStrings.myRequestsBrowsePhotographers.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
