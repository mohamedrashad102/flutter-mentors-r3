import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_helper.dart';
import '../models/auth_request_models.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> register(RegisterRequestModel params);
  Future<LoginResponseModel> login(LoginRequestModel params);
  Future<void> verifyEmail(VerifyEmailRequestModel params);
  Future<LoginResponseModel> refreshToken(RefreshTokenRequestModel params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDataSourceImpl({required this.dioHelper});

  @override
  Future<LoginResponseModel> login(LoginRequestModel params) async {
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
  Future<LoginResponseModel> refreshToken(RefreshTokenRequestModel params) async {
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
