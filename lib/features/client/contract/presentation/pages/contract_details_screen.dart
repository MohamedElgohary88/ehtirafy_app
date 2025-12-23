import 'package:easy_localization/easy_localization.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_details_entity.dart';
import 'package:ehtirafy_app/features/client/contract/presentation/manager/contract_details_cubit.dart';
import 'package:ehtirafy_app/features/client/contract/presentation/manager/contract_details_state.dart';
import 'package:ehtirafy_app/features/client/contract/presentation/widgets/contract_header.dart';
import 'package:ehtirafy_app/features/client/contract/presentation/widgets/contract_info_card.dart';
import 'package:ehtirafy_app/features/client/contract/presentation/widgets/contract_status_widgets.dart';
import 'package:ehtirafy_app/features/client/contract/presentation/widgets/payment_status_card.dart';
import 'package:ehtirafy_app/features/client/booking/presentation/widgets/states/order_details_awaiting_payment_view.dart';
import 'package:ehtirafy_app/features/client/booking/presentation/widgets/states/order_details_completed_view.dart';
import 'package:ehtirafy_app/features/client/booking/presentation/widgets/states/order_details_cancelled_view.dart';
import 'package:ehtirafy_app/features/client/contract/presentation/widgets/work_stages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ContractDetailsScreen extends StatelessWidget {
  final String contractId;

  const ContractDetailsScreen({super.key, required this.contractId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ContractDetailsCubit>()..getContractDetails(contractId),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppStrings.contractDetailsTitle.tr(),
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textPrimary,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<ContractDetailsCubit, ContractDetailsState>(
          builder: (context, state) {
            if (state is ContractDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ContractDetailsError) {
              return Center(
                child: Text(
                  state.message.tr(),
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
              );
            } else if (state is ContractDetailsSuccess) {
              return _buildContent(context, state.contract);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ContractDetailsEntity contract) {
    if (contract.status == ContractStatus.underReview) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: ContractUnderReviewCard(contract: contract),
      );
    }

    if (contract.status == ContractStatus.awaitingPayment) {
      return OrderDetailsAwaitingPaymentView(contract: contract);
    }

    if (contract.status == ContractStatus.completed) {
      return OrderDetailsCompletedView(contract: contract);
    }

    if (contract.status == ContractStatus.cancelled ||
        contract.status == ContractStatus.rejected) {
      return OrderDetailsCancelledView(contract: contract);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContractHeader(contract: contract),
          SizedBox(height: 16.h),
          ContractThreeStatusCard(contract: contract),
          SizedBox(height: 16.h),
          ContractInfoCard(contract: contract),
          SizedBox(height: 16.h),
          if (contract.status == ContractStatus.inProgress) ...[
            PaymentStatusCard(contract: contract),
            SizedBox(height: 16.h),
            WorkStagesList(contract: contract),
            SizedBox(height: 16.h),
            const ContractInProgressActions(),
          ],
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
