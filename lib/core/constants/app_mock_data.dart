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
}
