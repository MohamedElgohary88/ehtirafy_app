class RegisterRequestParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String sex;
  final String materialStatus;
  final String phone;
  final String userType;
  final String countryCode;

  RegisterRequestParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.sex,
    required this.materialStatus,
    required this.phone,
    required this.userType,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'sex': sex,
      'material_status': materialStatus,
      'phone': phone,
      'user_type': userType,
      'country_code': countryCode,
    };
  }
}
