import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/custom_snackbar_x.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AuthCubit>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.showCustomSnackbar(
              message: 'Login Successfully',
              variant: SnackBarVariant.success,
            );
            context.go(AppRouter.home);
          } else if (state is AuthFailure) {
            context.showCustomSnackbar(
              message: state.failure.message,
              variant: SnackBarVariant.error,
            );
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(child: LoginForm()),
        ),
      ),
    );
  }
}
