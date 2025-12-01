import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';
import 'primary_button.dart';

class CustomEmptyState extends StatelessWidget {
  final String titleKey;
  final String? messageKey;
  final String? actionKey;
  final VoidCallback? onAction;

  const CustomEmptyState({
    super.key,
    required this.titleKey,
    this.messageKey,
    this.actionKey,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo_library_outlined, size: 64, color: AppColors.grey400),
            SizedBox(height: AppSpacing.md),
            Text(titleKey.tr(), style: theme.textTheme.titleLarge),
            if (messageKey != null) ...[
              SizedBox(height: AppSpacing.sm),
              Text(
                messageKey!.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionKey != null && onAction != null) ...[
              SizedBox(height: AppSpacing.lg),
              PrimaryButton(text: actionKey!.tr(), onPressed: onAction!),
            ]
          ],
        ),
      ),
    );
  }
}

