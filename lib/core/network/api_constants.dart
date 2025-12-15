class ApiConstants {
  static const String baseUrl = 'https://ehtraphy.site/Memory-App';
  static const String version = 'v1';

  // Auth Endpoints
  static const String register = '/api/$version/auth/register';
  static const String login = '/api/$version/auth/login';
  static const String forgotPassword = '/api/$version/auth/forgot-password';
  static const String resetPassword = '/api/$version/auth/reset-password';
  static const String sendOtp = '/api/$version/auth/send-otp';

  // Freelancer Endpoints
  // Advertisements endpoint - requires user_type query param:
  // - user_type=freelancer → Freelancer sees their own gigs
  // - user_type=publisher → Client sees all available ads
  static const String advertisements =
      '$baseUrl/api/$version/front/advertisements';
  static const String freelancerPortfolio =
      '$baseUrl/api/$version/front/our-works';

  // Profile Endpoints
  static const String profileData = '/api/$version/front/profile-data';
  static const String updateProfile = '/api/$version/front/update-data';

  // Settings Endpoints
  static const String privacyPolicy = '/api/$version/privacy-policy';
  static const String termsConditions = '/api/$version/terms-conditions';
  static const String contactUs = '/api/$version/contact-us';

  // Categories Endpoint
  static const String categories = '$baseUrl/api/$version/categories';

  // Contract Endpoints
  static const String initialContract =
      '$baseUrl/api/$version/front/initial-contract';
  static const String contractsRelative =
      '$baseUrl/api/$version/front/contracts-relative';
  static String updateContract(String id) =>
      '$baseUrl/api/$version/front/contract/$id/update';

  // Dashboard & Search & Home
  static String freelancerStatistics(String id) =>
      '$baseUrl/api/$version/freelancer/$id/statistics';
  static String freelancerLastContracts(String id) =>
      '$baseUrl/api/$version/freelancer/$id/last-contracts';
  static const String search = '$baseUrl/api/$version/search';
  static const String bestFreelancers =
      '$baseUrl/api/$version/best-freelancers';
}
