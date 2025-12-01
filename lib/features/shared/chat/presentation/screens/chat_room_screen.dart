import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = List.generate(12, (i) => i.isEven);
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.chatRoomTitle.tr())),
      body: ListView.builder(
        padding: EdgeInsets.all(AppSpacing.lg),
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final isMe = messages[index];
          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: AppSpacing.sm),
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isMe ? AppColors.gold : AppColors.grey200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isMe
                    ? AppStrings.chatSampleMine.tr()
                    : AppStrings.chatSampleOther.tr(),
                style: TextStyle(
                  color: isMe ? AppColors.dark : AppColors.textPrimary,
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: AppStrings.chatInputHint.tr(),
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.dark,
                ),
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
