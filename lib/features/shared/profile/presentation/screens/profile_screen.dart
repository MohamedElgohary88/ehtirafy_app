import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  final bool isClient;
  const ProfileScreen({super.key, required this.isClient});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.profileTitle.tr())),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.lg),
        children: [
          CircleAvatar(radius: 48, backgroundColor: AppColors.gold, child: Text('م')), // Placeholder
          SizedBox(height: AppSpacing.md),
          Text(isClient ? AppStrings.profileClientRole.tr() : AppStrings.profileFreelancerRole.tr(), style: theme.textTheme.titleMedium),
          SizedBox(height: AppSpacing.lg),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(AppStrings.profileTransactions.tr()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppStrings.profileSettings.tr()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppStrings.profileLogout.tr()),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

