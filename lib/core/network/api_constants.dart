class ApiConstants {
  static const String baseUrl = 'https://ehtraphy.site/Memory-App';
  static const String version = 'v1';

  // Auth Endpoints
  static const String register = '/api/$version/auth/register';
  static const String login = '/api/$version/auth/login';
  static const String forgotPassword = '/api/$version/auth/forgot-password';
  static const String freelancerAdvertisements =
      '$baseUrl/front/advertisements';
  static const String freelancerPortfolio = '$baseUrl/front/our-works';
  // Contract Endpoints
  static const String initialContract = '$baseUrl/front/initial-contract';
  static const String contractsRelative = '$baseUrl/front/contracts-reltive';
  static String updateContract(String id) =>
      '$baseUrl/front/contract/$id/update';
}
