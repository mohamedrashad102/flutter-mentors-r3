import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';

class VerifyEmailForm extends StatefulWidget {
  const VerifyEmailForm({super.key, required this.email});

  final String email;

  @override
  State<VerifyEmailForm> createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().verifyEmail(
        email: widget.email,
        otp: _otpController.text,
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
            'Enter OTP',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryTextLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'An OTP has been sent to ${widget.email}',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.primaryTextLight),
          ),
          const SizedBox(height: 40),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              String? otpError;
              if (state is AuthFailure && state.failure.errorDetails != null) {
                final errors = state.failure.errorDetails!['otp'];
                if (errors is List && errors.isNotEmpty) {
                  otpError = errors.first;
                }
              }
              return CustomTextField(
                controller: _otpController,
                labelText: 'OTP',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
                errorText: otpError,
              );
            },
          ),
          const SizedBox(height: 40),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return CustomButton(
                onPressed: _submit,
                text: 'Verify',
                isLoading: state is AuthLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
