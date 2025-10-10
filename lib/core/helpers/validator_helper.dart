class ValidatorHelper {
  /// Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Validate password strength
  static String? validatePassword(
    String? value, {
    int minLength = 6,
    bool isLogin = false,
  }) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    if (isLogin) {
      return null;
    }
    final hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'\d'));
    final hasSpecialChar = value.contains(RegExp(r'[!@#\$&*~]'));

    if (!hasUpperCase || !hasLowerCase || !hasDigit || !hasSpecialChar) {
      return 'Password must contain upper, lower, number & special character';
    }
    return null;
  }

  /// Validate phone number (basic international format)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  /// Validate a required text field
  static String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate username (letters, numbers, underscores)
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Username must be 3–20 chars (letters, numbers, underscores only)';
    }
    return null;
  }
}
