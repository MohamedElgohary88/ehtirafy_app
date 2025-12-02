import 'package:equatable/equatable.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constants/app_strings.dart';

/// Base class for all failures in the app
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when there's a server error
class ServerFailure extends Failure {
  ServerFailure([String message = ''])
    : super(message.isEmpty ? AppStrings.failureServer.tr() : message);
}

/// Failure when there's a cache error
class CacheFailure extends Failure {
  CacheFailure([String message = ''])
    : super(message.isEmpty ? AppStrings.failureCache.tr() : message);
}

/// Failure when there's a network error
class NetworkFailure extends Failure {
  NetworkFailure([String message = ''])
    : super(message.isEmpty ? AppStrings.failureNetwork.tr() : message);
}

/// Failure when validation fails
class ValidationFailure extends Failure {
  ValidationFailure([String message = ''])
    : super(message.isEmpty ? AppStrings.failureValidation.tr() : message);
}

/// Failure when authentication fails
class AuthenticationFailure extends Failure {
  AuthenticationFailure([String message = ''])
    : super(message.isEmpty ? AppStrings.failureAuthentication.tr() : message);
}

/// Failure when authorization fails
class AuthorizationFailure extends Failure {
  AuthorizationFailure([String message = ''])
    : super(message.isEmpty ? AppStrings.failureAuthorization.tr() : message);
}

/// Failure when an unexpected error occurs
class UnexpectedFailure extends Failure {
  UnexpectedFailure([String message = ''])
    : super(message.isEmpty ? AppStrings.failureUnexpected.tr() : message);
}
