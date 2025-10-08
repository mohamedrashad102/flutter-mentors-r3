import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/custom_snackbar_x.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AuthCubit>(),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'), centerTitle: true),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            context.go(AppRouter.verifyEmail, extra: state.email);
          } else if (state is AuthFailure) {
            context.showCustomSnackbar(
              message: state.failure.message,
              variant: SnackBarVariant.error,
            );
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(child: RegisterForm()),
        ),
      ),
    );
  }
}
