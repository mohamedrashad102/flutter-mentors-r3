class LoginResponse {
  final String accessToken;
  final DateTime expiresAtUtc;
  final String refreshToken;

  LoginResponse({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
  });
}
