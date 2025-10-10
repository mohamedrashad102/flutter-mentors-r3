import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final Map<String, dynamic>? errorDetails;

  const Failure(this.message, {this.errorDetails});

  @override
  List<Object?> get props => [message, errorDetails];

  String? get passwordError {
    String? error;
    if (errorDetails != null) {
      final errors = errorDetails!['password'];
      if (errors is List && errors.isNotEmpty) {
        error = errors.first;
      }
    }
    return error;
  }

  String? get emailError {
    String? error;
    if (errorDetails != null) {
      final errors = errorDetails!['email'];
      if (errors is List && errors.isNotEmpty) {
        error = errors.first;
      }
    }
    return error;
  }

  String? get otpError {
    String? error;
    if (errorDetails != null) {
      final errors = errorDetails!['otp'];
      if (errors is List && errors.isNotEmpty) {
        error = errors.first;
      }
    }
    return error;
  }

  String? get firstNameError {
    String? error;
    if (errorDetails != null) {
      final errors = errorDetails!['firstName'];
      if (errors is List && errors.isNotEmpty) {
        error = errors.first;
      }
    }
    return error;
  }

  String? get lastNameError {
    String? error;
    if (errorDetails != null) {
      final errors = errorDetails!['lastName'];
      if (errors is List && errors.isNotEmpty) {
        error = errors.first;
      }
    }
    return error;
  }
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.errorDetails});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.errorDetails});
}
