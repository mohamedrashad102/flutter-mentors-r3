import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';

class RegisterFirstNameField extends StatelessWidget {
  const RegisterFirstNameField({
    super.key,
    required TextEditingController firstNameController,
  }) : _firstNameController = firstNameController;

  final TextEditingController _firstNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        String? firstNameError;
        if (state is AuthFailure) {
          firstNameError = state.failure.firstNameError;
        }
        return CustomTextField(
          controller: _firstNameController,
          labelText: 'First Name',
          validator: (value) =>
              ValidatorHelper.validateRequired(value, fieldName: 'First Name'),
          errorText: firstNameError,
        );
      },
    );
  }
}
