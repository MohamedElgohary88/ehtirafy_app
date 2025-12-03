import 'package:flutter/material.dart';
import 'package:ehtirafy_app/core/theme/app_colors.dart';

class AppMockData {
  static final List<Map<String, dynamic>> notifications = [
    {
      'id': '1',
      'title': 'رسالة جديدة من أحمد المصور',
      'body': 'شكراً لك، سأكون جاهزاً في الموعد',
      'time': 'منذ 5 دقائق',
      'isUnread': true,
      'type': 'message',
    },
    {
      'id': '2',
      'title': 'تم إتمام الخدمة',
      'body': 'محمد الفوتوغرافي أكمل الخدمة',
      'time': 'منذ 3 ساعات',
      'isUnread': true,
      'type': 'success',
    },
    {
      'id': '3',
      'title': 'تذكير: قيّم المصور',
      'body': 'شارك تجربتك مع محمد',
      'time': 'منذ 5 ساعات',
      'isUnread': false,
      'type': 'info',
    },
    {
      'id': '4',
      'title': 'تم إيداع المبلغ',
      'body': 'تم إيداع 5,000 ريال بشكل آمن',
      'time': 'منذ يوم',
      'isUnread': false,
      'type': 'success',
    },
  ];

  static final List<String> recentSearches = [
    'تصوير أفراح',
    'جلسات تصوير',
    'تصوير منتجات',
  ];

  static final List<String> popularSearchTags = [
    'أفراح',
    'عائلي',
    'منتجات',
    'عقارات',
    'طعام',
    'مناسبات',
  ];

  static final List<Map<String, dynamic>> photographers = [
    {
      'id': '1',
      'name': 'أحمد المصور',
      'category': 'تصوير حفلات زفاف',
      'rating': 4.9,
      'reviewsCount': 127,
      'location': 'الرياض',
      'price': 5000,
      'imageUrl': 'https://placehold.co/80x80.png',
    },
    {
      'id': '2',
      'name': 'سارة محمد',
      'category': 'تصوير أطفال',
      'rating': 4.8,
      'reviewsCount': 95,
      'location': 'جدة',
      'price': 3500,
      'imageUrl': 'https://placehold.co/80x80.png',
    },
    {
      'id': '3',
      'name': 'استوديو الإبداع',
      'category': 'تصوير منتجات',
      'rating': 4.7,
      'reviewsCount': 210,
      'location': 'الدمام',
      'price': 4000,
      'imageUrl': 'https://placehold.co/80x80.png',
    },
  ];
  static const Map<String, dynamic> mockFreelancerProfile = {
    'id': '1',
    'name': 'أحمد المصور',
    'title': 'تصوير حفلات زفاف ومناسبات',
    'location': 'الرياض، المملكة العربية السعودية',
    'bio':
        'مصور فوتوغرافي محترف متخصص في تصوير حفلات الزفاف والمناسبات الخاصة. أمتلك خبرة تزيد عن 10 سنوات مع أحدث المعدات.',
    'rating': 4.9,
    'reviewsCount': 127,
    'projectsCount': 156,
    'responseTime': 'خلال ساعة',
    'memberSince': '2020',
    'imageUrl': 'https://placehold.co/80x79.png',
    'portfolio': [
      {
        'id': '1',
        'title': 'حفل زفاف خالد وسارة',
        'category': 'أفراح',
        'imageUrl': 'https://placehold.co/166x166.png',
      },
      {
        'id': '2',
        'title': 'جلسة تصوير عائلية',
        'category': 'عائلات',
        'imageUrl': 'https://placehold.co/166x166.png',
      },
      {
        'id': '3',
        'title': 'منتجات شركة القهوة',
        'category': 'منتجات',
        'imageUrl': 'https://placehold.co/166x166.png',
      },
      {
        'id': '4',
        'title': 'حفل تخرج جامعة الملك سعود',
        'category': 'مناسبات',
        'imageUrl': 'https://placehold.co/166x166.png',
      },
    ],
    'services': [
      {
        'id': '1',
        'title': 'تصوير زفاف كامل',
        'price': 5000,
        'description': 'تغطية شاملة لحفل الزفاف لمدة 8 ساعات مع ألبوم فاخر.',
      },
      {
        'id': '2',
        'title': 'جلسة تصوير خارجية',
        'price': 1500,
        'description': 'جلسة تصوير في موقع خارجي لمدة ساعتين مع تعديل الصور.',
      },
    ],
    'reviews': [
      {
        'id': '1',
        'userName': 'محمد العتيبي',
        'userImage': 'https://placehold.co/40x40.png',
        'rating': 5.0,
        'date': 'منذ يومين',
        'comment': 'مصور رائع ومحترف جداً، الصور كانت مذهلة والتعامل راقي.',
      },
      {
        'id': '2',
        'userName': 'سارة الأحمد',
        'userImage': 'https://placehold.co/40x40.png',
        'rating': 4.8,
        'date': 'منذ أسبوع',
        'comment': 'تجربة ممتازة، الصور جميلة ولكن التأخير بسيط في التسليم.',
      },
    ],
  };

  static const Map<String, dynamic> mockBookingSuccessResponse = {
    'success': true,
    'message': 'تم إرسال طلبك بنجاح',
    'bookingId': '12345',
    'status': 'pending',
  };

  static final List<Map<String, dynamic>> mockMyRequests = [
    {
      'id': '1',
      'serviceName': 'جلسة تصوير عائلية',
      'photographerName': 'أحمد المصور',
      'photographerImage': 'https://placehold.co/40x40.png',
      'status': 'active',
      'price': 2500,
      'date': DateTime.now()
          .subtract(const Duration(days: 5))
          .toIso8601String(),
      'isPaymentRequired': true,
      'approvedDate': DateTime.now()
          .subtract(const Duration(minutes: 30))
          .toIso8601String(),
    },
    {
      'id': '2',
      'serviceName': 'تصوير منتجات للمتجر',
      'photographerName': 'أحمد المصور',
      'photographerImage': 'https://placehold.co/40x40.png',
      'status': 'underReview',
      'price': 3000,
      'date': DateTime.now()
          .subtract(const Duration(hours: 5))
          .toIso8601String(),
      'isPaymentRequired': false,
    },
    {
      'id': '3',
      'serviceName': 'تصوير مناسبة',
      'photographerName': 'نور العدسة',
      'photographerImage': 'https://placehold.co/40x40.png',
      'status': 'cancelled',
      'price': 4000,
      'date': DateTime.now()
          .subtract(const Duration(days: 30))
          .toIso8601String(),
      'isPaymentRequired': false,
    },
    {
      'id': '4',
      'serviceName': 'تصوير حفل تخرج',
      'photographerName': 'سارة محمد',
      'photographerImage': 'https://placehold.co/40x40.png',
      'status': 'completed',
      'price': 1500,
      'date': DateTime.now()
          .subtract(const Duration(days: 10))
          .toIso8601String(),
      'isPaymentRequired': false,
    },
  ];
}
