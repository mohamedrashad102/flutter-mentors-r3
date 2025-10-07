import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/login_response.dart';

class RegisterParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

class VerifyEmailParams {
  final String email;
  final String otp;

  VerifyEmailParams({
    required this.email,
    required this.otp,
  });
}

class RefreshTokenParams {
  final String refreshToken;

  RefreshTokenParams({required this.refreshToken});
}

abstract class AuthRepository {
  Future<Either<Failure, void>> register(RegisterParams params);
  Future<Either<Failure, LoginResponse>> login(LoginParams params);
  Future<Either<Failure, void>> verifyEmail(VerifyEmailParams params);
  Future<Either<Failure, LoginResponse>> refreshToken(RefreshTokenParams params);
}
