import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';

class RegisterEmailField extends StatelessWidget {
  const RegisterEmailField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        String? emailError;
        if (state is AuthFailure && state.failure.errorDetails != null) {
          final errors = state.failure.errorDetails!['email'];
          if (errors is List && errors.isNotEmpty) {
            emailError = errors.first;
          }
        }
        return CustomTextField(
          controller: _emailController,
          labelText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: (value) => ValidatorHelper.validateEmail(value),
          errorText: emailError,
        );
      },
    );
  }
}
