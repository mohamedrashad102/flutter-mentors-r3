import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../cubit/auth_cubit.dart';
import 'login_button.dart';
import 'login_email_form.dart';
import 'login_password_form.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            'Welcome Back!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryTextLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          LoginEmailForm(emailController: _emailController),
          const SizedBox(height: 20),
          LoginPasswordForm(passwordController: _passwordController),
          const SizedBox(height: 40),
          LoginButton(onSubmit: _submit),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => context.go(AppRouter.register),
            child: const Text('Don\'t have an account? Sign up'),
          ),
        ],
      ),
    );
  }
}
