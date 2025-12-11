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
  static const String freelancerAdvertisements =
      '$baseUrl/api/$version/advertisements';
  static const String freelancerPortfolio =
      '$baseUrl/api/$version/front/our-works';

  // Categories Endpoint
  static const String categories = '$baseUrl/api/$version/categories';

  // Contract Endpoints
  static const String initialContract = '$baseUrl/front/initial-contract';
  static const String contractsRelative = '$baseUrl/front/contracts-reltive';
  static String updateContract(String id) =>
      '$baseUrl/front/contract/$id/update';
}
