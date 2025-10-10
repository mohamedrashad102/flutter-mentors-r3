import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';

class RegisterLastNameField extends StatelessWidget {
  const RegisterLastNameField({
    super.key,
    required TextEditingController lastNameController,
  }) : _lastNameController = lastNameController;

  final TextEditingController _lastNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        String? lastNameError;
        if (state is AuthFailure) {
          lastNameError = state.failure.lastNameError;
        }
        return CustomTextField(
          controller: _lastNameController,
          labelText: 'Last Name',
          validator: (value) =>
              ValidatorHelper.validateRequired(value, fieldName: 'Last Name'),
          errorText: lastNameError,
        );
      },
    );
  }
}
