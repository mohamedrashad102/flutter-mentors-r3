import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import 'email_input.dart';

class LoginEmailForm extends StatelessWidget {
  const LoginEmailForm({
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
        return EmailInput(controller: _emailController, errorText: emailError);
      },
    );
  }
}
