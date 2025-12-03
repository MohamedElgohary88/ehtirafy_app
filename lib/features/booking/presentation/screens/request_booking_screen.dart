import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:ehtirafy_app/core/constants/app_strings.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';
import 'package:ehtirafy_app/features/booking/domain/entities/booking_request_entity.dart';
import 'package:ehtirafy_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:ehtirafy_app/features/booking/presentation/cubit/booking_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestBookingScreen extends StatefulWidget {
  final String freelancerId;
  final String freelancerName;
  final String serviceName;
  final double price;

  const RequestBookingScreen({
    super.key,
    required this.freelancerId,
    required this.freelancerName,
    required this.serviceName,
    required this.price,
  });

  @override
  State<RequestBookingScreen> createState() => _RequestBookingScreenState();
}

class _RequestBookingScreenState extends State<RequestBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BookingCubit>(),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            context.go('/booking/success');
          } else if (state is BookingError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppStrings.bookingRequestTitle.tr()),
              backgroundColor: const Color(0xFF2B2B2B),
              foregroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildServiceCard(),
                    SizedBox(height: 24.h),
                    Text(
                      AppStrings.bookingDetailsTitle.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF2B2B2B),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      AppStrings.bookingDetailsSubtitle.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF888888),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildInputField(
                      label: AppStrings.bookingEventDate.tr(),
                      controller: _dateController,
                      isRequired: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          _dateController.text = DateFormat(
                            'yyyy-MM-dd',
                          ).format(date);
                        }
                      },
                      readOnly: true,
                    ),
                    SizedBox(height: 20.h),
                    _buildInputField(
                      label: AppStrings.bookingStartTime.tr(),
                      controller: _timeController,
                      isRequired: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          _timeController.text = time.format(context);
                        }
                      },
                      readOnly: true,
                    ),
                    SizedBox(height: 20.h),
                    _buildInputField(
                      label: AppStrings.bookingLocation.tr(),
                      controller: _locationController,
                      hint: AppStrings.bookingLocationHint.tr(),
                      isRequired: true,
                    ),
                    SizedBox(height: 20.h),
                    _buildNotesField(),
                    SizedBox(height: 24.h),
                    _buildImportantNote(),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: state is BookingLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final request = BookingRequestEntity(
                                    serviceId: '1', // Mock service ID
                                    freelancerId: widget.freelancerId,
                                    date: _dateController.text,
                                    time: _timeController.text,
                                    location: _locationController.text,
                                    notes: _notesController.text,
                                  );
                                  context.read<BookingCubit>().submitBooking(
                                    request,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: state is BookingLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                AppStrings.bookingSubmitButton.tr(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFC8A44F).withOpacity(0.1),
            Colors.black.withOpacity(0),
          ],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFC8A44F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.bookingServiceRequired.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF888888),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.serviceName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF2B2B2B),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFC8A44F), Color(0xFFB8944F)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.freelancerName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF2B2B2B),
                    ),
                  ),
                  Text(
                    AppStrings.bookingPhotographer.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.bookingCurrency.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF888888),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        widget.price.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFC8A44F),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppStrings.bookingPrice.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? hint,
    bool isRequired = false,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0A0A0A),
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF3F3F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.bookingNotesTitle.tr(),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0A0A0A),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _notesController,
          maxLines: 4,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: AppStrings.bookingNotesHint.tr(),
            filled: true,
            fillColor: const Color(0xFFF3F3F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImportantNote() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF17A2B8).withOpacity(0.1),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF17A2B8).withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.bookingImportantNoteTitle.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  AppStrings.bookingImportantNoteBody.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF888888),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 8.w,
            height: 8.w,
            decoration: const BoxDecoration(
              color: Color(0xFF17A2B8),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
