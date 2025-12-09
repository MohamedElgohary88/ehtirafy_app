import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? countryCode;
  final String? sex;
  final String? materialStatus;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.countryCode,
    this.sex,
    this.materialStatus,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    countryCode,
    sex,
    materialStatus,
  ];
}
