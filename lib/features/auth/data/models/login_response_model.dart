import '../../domain/entities/login_response.dart';

class LoginResponseModel extends LoginResponse {
  LoginResponseModel({
    required super.accessToken,
    required super.expiresAtUtc,
    required super.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'],
      expiresAtUtc: DateTime.parse(json['expiresAtUtc']),
      refreshToken: json['refreshToken'],
    );
  }
}
