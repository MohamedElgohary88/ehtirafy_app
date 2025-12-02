import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';
import 'package:ehtirafy_app/features/client/search/presentation/cubits/search_cubit.dart';
import 'package:ehtirafy_app/features/client/search/presentation/cubits/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>()..loadInitialData(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message.tr()));
                  } else if (state is SearchLoaded) {
                    if (state.searchResults != null) {
                      return ListView.builder(
                        padding: EdgeInsets.all(24.w),
                        itemCount: state.searchResults!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.searchResults![index].title),
                          );
                        },
                      );
                    }
                    return ListView(
                      padding: EdgeInsets.all(24.w),
                      children: [
                        _buildSectionTitle(
                          context,
                          AppStrings.searchRecentSearches.tr(),
                        ),
                        SizedBox(height: 12.h),
                        ...state.recentSearches.map(
                          (e) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: _buildRecentSearchItem(context, e.title),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        _buildSectionTitle(
                          context,
                          AppStrings.searchMostSearched.tr(),
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: state.popularTags
                              .map((e) => _buildSearchTag(context, e.title))
                              .toList(),
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
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.dark,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          decoration: const BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Container(
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: AppColors.grey600, size: 24.w),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            return TextField(
                              onSubmitted: (query) =>
                                  context.read<SearchCubit>().search(query),
                              decoration: InputDecoration(
                                hintText: AppStrings.searchHint.tr(),
                                hintStyle: TextStyle(
                                  color: AppColors.grey400,
                                  fontSize: 14.sp,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showFilterBottomSheet(context),
                        child: Icon(
                          Icons.tune,
                          color: AppColors.gold,
                          size: 24.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildRecentSearchItem(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
          Icon(Icons.close, color: AppColors.grey400, size: 16.w),
        ],
      ),
    );
  }

  Widget _buildSearchTag(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }
}

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.searchFilterTitle.tr(),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Text(
            AppStrings.searchFilterPriceRange.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 16.h),
          // Placeholder for Price Range Slider
          Container(
            height: 48.h,
            color: AppColors.grey100,
            child: const Center(child: Text('Price Slider Placeholder')),
          ),
          SizedBox(height: 24.h),
          Text(
            AppStrings.searchFilterRating.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 16.h),
          // Placeholder for Rating Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) =>
                  Icon(Icons.star_border, color: AppColors.gold, size: 32.w),
            ),
          ),
          SizedBox(height: 32.h),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              AppStrings.searchFilterApply.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
