import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import 'password_input.dart';

class LoginPasswordForm extends StatelessWidget {
  const LoginPasswordForm({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        String? passwordError;
        if (state is AuthFailure) {
          passwordError = state.failure.passwordError;
        }
        return PasswordInput(
          controller: _passwordController,
          errorText: passwordError,
          isLogin: true,
        );
      },
    );
  }
}
