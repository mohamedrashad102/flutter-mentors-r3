import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';

class RegisterPasswordField extends StatelessWidget {
  const RegisterPasswordField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        String? passwordError;
        if (state is AuthFailure &&
            state.failure.errorDetails != null) {
          final errors =
              state.failure.errorDetails!['password'];
          if (errors is List && errors.isNotEmpty) {
            passwordError = errors.first;
          }
        }
        return CustomTextField(
          controller: _passwordController,
          labelText: 'Password',
          obscureText: true,
          validator: (value) => ValidatorHelper.validatePassword(value),
          errorText: passwordError,
        );
      },
    );
  }
}
