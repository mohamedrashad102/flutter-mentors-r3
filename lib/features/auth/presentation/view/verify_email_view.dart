import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/custom_snackbar_x.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/verify_email_form.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AuthCubit>(),
      child: VerifyEmailView(email: email),
    );
  }
}

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email'), centerTitle: true),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerificationSuccess) {
            context.showCustomSnackbar(
              message: 'Email Verified Successfully!',
              variant: SnackBarVariant.success,
            );
            context.go(AppRouter.login);
          } else if (state is AuthFailure) {
            context.showCustomSnackbar(
              message: state.failure.message,
              variant: SnackBarVariant.error,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: VerifyEmailForm(email: email),
        ),
      ),
    );
  }
}
