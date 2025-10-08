import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/auth_cubit.dart';
import 'register_email_field.dart';
import 'register_first_name_field.dart';
import 'register_last_name_field.dart';
import 'register_password_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
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
            'Create an Account',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryTextLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          RegisterFirstNameField(firstNameController: _firstNameController),
          const SizedBox(height: 20),
          RegisterLastNameField(lastNameController: _lastNameController),
          const SizedBox(height: 20),
          RegisterEmailField(emailController: _emailController),
          const SizedBox(height: 20),
          RegisterPasswordField(passwordController: _passwordController),
          const SizedBox(height: 40),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return CustomButton(
                onPressed: _submit,
                text: 'Register',
                isLoading: state is AuthLoading,
              );
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => context.go(AppRouter.login),
            child: const Text("Already have an account? Login"),
          ),
        ],
      ),
    );
  }
}
