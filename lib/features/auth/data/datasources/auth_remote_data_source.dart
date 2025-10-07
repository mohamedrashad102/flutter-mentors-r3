import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_helper.dart';
import '../../domain/entities/login_response.dart';
import '../models/auth_request_models.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> register(RegisterRequestModel params);
  Future<LoginResponse> login(LoginRequestModel params);
  Future<void> verifyEmail(VerifyEmailRequestModel params);
  Future<LoginResponse> refreshToken(RefreshTokenRequestModel params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDataSourceImpl({required this.dioHelper});

  @override
  Future<LoginResponse> login(LoginRequestModel params) async {
    try {
      final response = await dioHelper.post(
        '/auth/login',
        data: params.toJson(),
      );
      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Unknown error');
    }
  }

  @override
  Future<void> register(RegisterRequestModel params) async {
    try {
      await dioHelper.post(
        '/auth/register',
        data: params.toJson(),
      );
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Unknown error');
    }
  }

  @override
  Future<void> verifyEmail(VerifyEmailRequestModel params) async {
    try {
      await dioHelper.post(
        '/auth/verify-email',
        data: params.toJson(),
      );
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Unknown error');
    }
  }

  @override
  Future<LoginResponse> refreshToken(RefreshTokenRequestModel params) async {
    try {
      final response = await dioHelper.post(
        '/auth/refresh-token',
        data: params.toJson(),
      );
      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Unknown error');
    }
  }
}
