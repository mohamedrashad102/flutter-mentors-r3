import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/dio_exception_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/dio_helper.dart';
import '../../domain/entities/login_response.dart';
import '../models/auth_request_models.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, void>> register(RegisterRequestModel params);
  Future<Either<Failure, LoginResponse>> login(LoginRequestModel params);
  Future<Either<Failure, void>> verifyEmail(VerifyEmailRequestModel params);
  Future<Either<Failure, LoginResponse>> refreshToken(
    RefreshTokenRequestModel params,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDataSourceImpl({required this.dioHelper});

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequestModel params) async {
    try {
      final response = await dioHelper.post(
        '/auth/login',
        data: params.toJson(),
      );
      final loginResponse = LoginResponseModel.fromJson(response.data);
      return Right(loginResponse);
    } on DioException catch (e) {
      final apiException = DioExceptionHandler.handleException(e);
      return Left(
        ServerFailure(
          apiException.message,
          errorDetails: apiException.errorDetails,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> register(RegisterRequestModel params) async {
    try {
      await dioHelper.post('/auth/register', data: params.toJson());
      return const Right(null);
    } on DioException catch (e) {
      final apiException = DioExceptionHandler.handleException(e);
      return Left(
        ServerFailure(
          apiException.message,
          errorDetails: apiException.errorDetails,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail(
    VerifyEmailRequestModel params,
  ) async {
    try {
      await dioHelper.post('/auth/verify-email', data: params.toJson());
      return const Right(null);
    } on DioException catch (e) {
      final apiException = DioExceptionHandler.handleException(e);
      return Left(
        ServerFailure(
          apiException.message,
          errorDetails: apiException.errorDetails,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> refreshToken(
    RefreshTokenRequestModel params,
  ) async {
    try {
      final response = await dioHelper.post(
        '/auth/refresh-token',
        data: params.toJson(),
      );
      return Right(LoginResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      final apiException = DioExceptionHandler.handleException(e);
      return Left(
        ServerFailure(
          apiException.message,
          errorDetails: apiException.errorDetails,
        ),
      );
    }
  }
}
