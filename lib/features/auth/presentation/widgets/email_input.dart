import 'package:flutter/material.dart';

import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/widgets/custom_text_field.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key, required this.controller, this.errorText});

  final TextEditingController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Email',
      errorText: errorText,
      keyboardType: TextInputType.emailAddress,
      validator: ValidatorHelper.validateEmail,
    );
  }
}
