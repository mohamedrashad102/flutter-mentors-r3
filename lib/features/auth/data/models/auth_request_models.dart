class RegisterRequestModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class VerifyEmailRequestModel {
  final String email;
  final String otp;

  VerifyEmailRequestModel({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }
}

class RefreshTokenRequestModel {
  final String refreshToken;
  final bool useCookies;

  RefreshTokenRequestModel({
    required this.refreshToken,
    this.useCookies = false,
  });

  Map<String, dynamic> toJson() {
    return {'refreshToken': refreshToken, 'useCookies': useCookies};
  }
}
