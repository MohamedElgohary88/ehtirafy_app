class ApiConstants {
  static const String baseUrl = 'https://ehtraphy.site/Memory-App';
  static const String version = 'v1';

  // Auth Endpoints
  static const String register = '/api/$version/auth/register';
  static const String login = '/api/$version/auth/login';
  static const String forgotPassword =
      '/api/$version/auth/forgot-password'; // Path only as per original pattern if used with dio base url, or full url if needed. Original was path.
  static const String resetPassword =
      '$baseUrl/api/$version/auth/reset-password'; // User request said: {{test_server}}/api/{{version}}/auth/reset-password
  static const String freelancerAdvertisements =
      '$baseUrl/front/advertisements';
  static const String freelancerPortfolio = '$baseUrl/front/our-works';
  // Contract Endpoints
  static const String initialContract = '$baseUrl/front/initial-contract';
  static const String contractsRelative = '$baseUrl/front/contracts-reltive';
  static String updateContract(String id) =>
      '$baseUrl/front/contract/$id/update';
}
