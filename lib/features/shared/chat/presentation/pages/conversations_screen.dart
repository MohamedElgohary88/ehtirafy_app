import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:go_router/go_router.dart';

import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/conversation_tile.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          AppStrings.chatListTitle.tr(),
          style: TextStyle(
            color: const Color(0xFF2B2B2B),
            fontSize: 20.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (previous, current) =>
            current is ConversationsLoaded ||
            current is ChatLoading ||
            current is ChatError,
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatError) {
            return Center(child: Text(state.message));
          } else if (state is ConversationsLoaded) {
            if (state.conversations.isEmpty) {
              return _buildEmptyState();
            }
            return ListView.separated(
              padding: EdgeInsets.all(24.w),
              itemCount: state.conversations.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final conv = state.conversations[index];
                return ConversationTile(
                  conversation: conv,
                  onTap: () {
                    context.push('/messages/chat/${conv.id}', extra: conv);
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              size: 40.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            AppStrings.chatNoMessages.tr(),
            style: TextStyle(
              color: const Color(0xFF2B2B2B),
              fontSize: 16.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppStrings.chatStartConversation.tr(),
            style: TextStyle(
              color: const Color(0xFF888888),
              fontSize: 16.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFC8A44F), width: 2),
            ),
            child: Text(
              AppStrings.chatFindPhotographer.tr(),
              style: TextStyle(
                color: const Color(0xFFC8A44F),
                fontSize: 14.sp,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
