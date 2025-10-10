import 'package:flutter/material.dart';

import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/widgets/custom_text_field.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required this.controller,
    this.errorText,
    this.isLogin = false,
  });

  final TextEditingController controller;
  final String? errorText;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Password',
      errorText: errorText,
      obscureText: true,
      validator: (value) =>
          ValidatorHelper.validatePassword(value, isLogin: isLogin),
    );
  }
}
