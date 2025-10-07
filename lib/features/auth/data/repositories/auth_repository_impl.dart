import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
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
    try {
      final remoteLogin = await remoteDataSource.login(
        LoginRequestModel(email: params.email, password: params.password),
      );
      return Right(remoteLogin);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> register(RegisterParams params) async {
    try {
      await remoteDataSource.register(
        RegisterRequestModel(
          email: params.email,
          password: params.password,
          firstName: params.firstName,
          lastName: params.lastName,
        ),
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail(VerifyEmailParams params) async {
    try {
      await remoteDataSource.verifyEmail(
        VerifyEmailRequestModel(email: params.email, otp: params.otp),
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> refreshToken(
      RefreshTokenParams params) async {
    try {
      final remoteLogin = await remoteDataSource.refreshToken(
        RefreshTokenRequestModel(refreshToken: params.refreshToken),
      );
      return Right(remoteLogin);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
