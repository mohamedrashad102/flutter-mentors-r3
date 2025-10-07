import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_request_models.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginResponse>> login(LoginParams params) async {
    return await remoteDataSource.login(
      LoginRequestModel(email: params.email, password: params.password),
    );
  }

  @override
  Future<Either<Failure, void>> register(RegisterParams params) async {
    return await remoteDataSource.register(
      RegisterRequestModel(
        email: params.email,
        password: params.password,
        firstName: params.firstName,
        lastName: params.lastName,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> verifyEmail(VerifyEmailParams params) async {
    return await remoteDataSource.verifyEmail(
      VerifyEmailRequestModel(email: params.email, otp: params.otp),
    );
  }

  @override
  Future<Either<Failure, LoginResponse>> refreshToken(
    RefreshTokenParams params,
  ) async {
    return await remoteDataSource.refreshToken(
      RefreshTokenRequestModel(refreshToken: params.refreshToken),
    );
  }
}
