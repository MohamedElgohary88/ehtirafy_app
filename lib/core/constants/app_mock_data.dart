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
      'id': '101',
      'serviceName': 'جلسة تصوير عائلية',
      'photographerName': 'أحمد المصور',
      'photographerImage': 'https://placehold.co/40x40.png',
      'status': 'underReview',
      'price': 2500,
      'date': DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
      'isPaymentRequired': false,
    },
    {
      'id': '102',
      'serviceName': 'تصوير منتجات للمتجر',
      'photographerName': 'سارة محمد',
      'photographerImage': 'https://placehold.co/40x40.png',
      'status': 'active',
      'price': 3000,
      'date': DateTime.now()
          .subtract(const Duration(hours: 24))
          .toIso8601String(),
      'isPaymentRequired': true,
      'approvedDate': DateTime.now()
          .subtract(const Duration(minutes: 30))
          .toIso8601String(),
    },
    {
      'id': '103',
      'serviceName': 'تصوير حفل زفاف',
      'photographerName': 'استوديو الإبداع',
      'photographerImage': 'https://placehold.co/40x40.png',
      'status': 'active',
      'price': 5000,
      'date': DateTime.now()
          .subtract(const Duration(days: 2))
          .toIso8601String(),
      'isPaymentRequired': false,
    },
  ];
  static final List<Map<String, dynamic>> mockContractDetails = [
    {
      'id': '101',
      'status': 'underReview',
      'serviceTitle': 'جلسة تصوير عائلية',
      'serviceCategory': 'تصوير عائلات',
      'description': 'جلسة تصوير عائلية في المنزل.',
      'location': 'الرياض',
      'date': '2024-12-28T16:00:00.000',
      'budget': 2500,
      'isPaymentDeposited': false,
      'photographerName': 'أحمد المصور',
      'photographerImage': 'https://placehold.co/80x80.png',
      'approvedAt': null,
    },
    {
      'id': '102',
      'status': 'awaitingPayment',
      'serviceTitle': 'تصوير منتجات للمتجر',
      'serviceCategory': 'تصوير منتجات',
      'description': 'تصوير منتجات لمتجر إلكتروني.',
      'location': 'جدة',
      'date': '2024-12-30T10:00:00.000',
      'budget': 3000,
      'isPaymentDeposited': false,
      'photographerName': 'سارة محمد',
      'photographerImage': 'https://placehold.co/80x80.png',
      'approvedAt': DateTime.now()
          .subtract(const Duration(minutes: 30))
          .toIso8601String(),
    },
    {
      'id': '103',
      'status': 'inProgress',
      'serviceTitle': 'تصوير حفل زفاف',
      'serviceCategory': 'تصوير حفلات زفاف',
      'description': 'تغطية حفل زفاف كامل.',
      'location': 'الدمام',
      'date': '2025-01-05T18:00:00.000',
      'budget': 5000,
      'isPaymentDeposited': true,
      'photographerName': 'استوديو الإبداع',
      'photographerImage': 'https://placehold.co/80x80.png',
      'approvedAt': DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
    },
  ];

  static Map<String, dynamic> getContractDetails(String id) {
    return mockContractDetails.firstWhere(
      (element) => element['id'] == id,
      orElse: () => mockContractDetails.first,
    );
  }

  // ========== FREELANCER MODULE MOCK DATA ==========

  /// Freelancer dashboard statistics
  static const Map<String, dynamic> mockFreelancerStats = {
    'totalEarnings': 25000.0,
    'activeOrders': 3,
    'profileViews': 156,
    'rating': 4.9,
    'isOnline': true,
  };

  /// Freelancer gigs (services offered)
  static final List<Map<String, dynamic>> mockFreelancerGigs = [
    {
      'id': 'gig-001',
      'title': 'تصوير حفلات زفاف احترافي',
      'description':
          'تغطية شاملة لحفل الزفاف تشمل جميع اللحظات المميزة مع معدات احترافية وخبرة 10 سنوات.',
      'price': 5000.0,
      'category': 'أفراح',
      'status': 'active',
      'coverImage': 'https://placehold.co/300x200.png',
      'createdAt': '2024-11-01T10:00:00.000',
    },
    {
      'id': 'gig-002',
      'title': 'جلسة تصوير عائلية',
      'description':
          'جلسة تصوير مميزة للعائلة في موقع خارجي أو استوديو مع تعديل احترافي للصور.',
      'price': 1500.0,
      'category': 'عائلات',
      'status': 'active',
      'coverImage': 'https://placehold.co/300x200.png',
      'createdAt': '2024-11-15T10:00:00.000',
    },
    {
      'id': 'gig-003',
      'title': 'تصوير منتجات تجارية',
      'description':
          'تصوير احترافي للمنتجات للمتاجر الإلكترونية مع خلفية بيضاء وإضاءة مثالية.',
      'price': 2500.0,
      'category': 'منتجات',
      'status': 'pending',
      'coverImage': 'https://placehold.co/300x200.png',
      'createdAt': '2024-12-01T10:00:00.000',
    },
  ];

  /// Freelancer portfolio items
  static final List<Map<String, dynamic>> mockFreelancerPortfolio = [
    {
      'id': 'portfolio-001',
      'title': 'حفل زفاف خالد وسارة',
      'description': 'تغطية كاملة لحفل زفاف فاخر في قصر الحكير بالرياض.',
      'cameraType': 'Canon EOS R5',
      'imageUrl': 'https://placehold.co/166x166.png',
      'category': 'أفراح',
      'createdAt': '2024-10-15T10:00:00.000',
    },
    {
      'id': 'portfolio-002',
      'title': 'جلسة تصوير عائلية',
      'description': 'جلسة تصوير لعائلة من 5 أفراد في حديقة السلام.',
      'cameraType': 'Sony A7 IV',
      'imageUrl': 'https://placehold.co/166x166.png',
      'category': 'عائلات',
      'createdAt': '2024-09-20T10:00:00.000',
    },
    {
      'id': 'portfolio-003',
      'title': 'منتجات شركة القهوة',
      'description': 'تصوير منتجات قهوة لمتجر إلكتروني.',
      'cameraType': 'Canon EOS R5',
      'imageUrl': 'https://placehold.co/166x166.png',
      'category': 'منتجات',
      'createdAt': '2024-08-10T10:00:00.000',
    },
    {
      'id': 'portfolio-004',
      'title': 'حفل تخرج جامعة الملك سعود',
      'description': 'تصوير مناسبة تخرج مع أكثر من 200 صورة.',
      'cameraType': 'Nikon Z8',
      'imageUrl': 'https://placehold.co/166x166.png',
      'category': 'مناسبات',
      'createdAt': '2024-07-05T10:00:00.000',
    },
  ];

  /// Freelancer incoming orders/requests
  static final List<Map<String, dynamic>> mockFreelancerOrders = [
    {
      'id': 'order-f001',
      'serviceTitle': 'جلسة تصوير عائلية',
      'clientName': 'فاطمة السالم',
      'clientImage': 'https://placehold.co/40x40.png',
      'status': 'pending',
      'price': 1500.0,
      'location': 'الرياض',
      'eventDate': '2024-12-28T16:00:00.000',
      'createdAt': DateTime.now()
          .subtract(const Duration(hours: 5))
          .toIso8601String(),
    },
    {
      'id': 'order-f002',
      'serviceTitle': 'تصوير حفل زفاف في الرياض',
      'clientName': 'محمد العتيبي',
      'clientImage': 'https://placehold.co/40x40.png',
      'status': 'inProgress',
      'price': 5000.0,
      'location': 'الرياض',
      'eventDate': '2025-01-05T18:00:00.000',
      'createdAt': DateTime.now()
          .subtract(const Duration(days: 3))
          .toIso8601String(),
    },
    {
      'id': 'order-f003',
      'serviceTitle': 'تصوير حفل زفاف',
      'clientName': 'عبدالله الشمري',
      'clientImage': 'https://placehold.co/40x40.png',
      'status': 'inProgress',
      'price': 5000.0,
      'location': 'جدة',
      'eventDate': '2025-01-10T19:00:00.000',
      'createdAt': DateTime.now()
          .subtract(const Duration(days: 2))
          .toIso8601String(),
    },
    {
      'id': 'order-f004',
      'serviceTitle': 'تصوير منتجات متجر',
      'clientName': 'نورة الحربي',
      'clientImage': 'https://placehold.co/40x40.png',
      'status': 'pending',
      'price': 2500.0,
      'location': 'الدمام',
      'eventDate': '2024-12-30T10:00:00.000',
      'createdAt': DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
    },
    {
      'id': 'order-f005',
      'serviceTitle': 'جلسة تصوير عائلية',
      'clientName': 'سارة الأحمد',
      'clientImage': 'https://placehold.co/40x40.png',
      'status': 'completed',
      'price': 1500.0,
      'location': 'الرياض',
      'eventDate': '2024-11-20T15:00:00.000',
      'createdAt': DateTime.now()
          .subtract(const Duration(days: 20))
          .toIso8601String(),
    },
    {
      'id': 'order-f006',
      'serviceTitle': 'تصوير حفل تخرج',
      'clientName': 'خالد القحطاني',
      'clientImage': 'https://placehold.co/40x40.png',
      'status': 'cancelled',
      'price': 3000.0,
      'location': 'الرياض',
      'eventDate': '2024-11-15T14:00:00.000',
      'createdAt': DateTime.now()
          .subtract(const Duration(days: 25))
          .toIso8601String(),
    },
  ];

  /// GIG categories for dropdown
  static const List<String> gigCategories = [
    'أفراح',
    'عائلات',
    'منتجات',
    'مناسبات',
    'عقارات',
    'طعام',
    'أزياء',
    'رياضة',
  ];
}
