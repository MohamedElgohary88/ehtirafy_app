import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class ClientMyRequestsScreen extends StatelessWidget {
  const ClientMyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.bookingRequestsTitle.tr()),
          bottom: TabBar(
            labelColor: AppColors.gold,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              Tab(text: AppStrings.bookingRequestsActive.tr()),
              Tab(text: AppStrings.bookingRequestsPending.tr()),
              Tab(text: AppStrings.bookingRequestsCompleted.tr()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _RequestsList(statusKey: AppStrings.bookingRequestsActive),
            _RequestsList(statusKey: AppStrings.bookingRequestsPending),
            _RequestsList(statusKey: AppStrings.bookingRequestsCompleted),
          ],
        ),
      ),
    );
  }
}

class _RequestsList extends StatelessWidget {
  final String statusKey;
  const _RequestsList({required this.statusKey});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(AppSpacing.lg),
      itemCount: 3,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.only(bottom: AppSpacing.md),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.grey700,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Text(AppStrings.bookingServiceWedding.tr()),
          subtitle: Text(
            '${AppStrings.bookingPhotographerPrefix.tr()} أحمد • 5000 ${AppStrings.bookingCurrency.tr()}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Chip(label: Text(statusKey.tr())),
        ),
      ),
    );
  }
}

