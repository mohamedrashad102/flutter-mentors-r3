import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class PlanContinueButton extends StatelessWidget {
  const PlanContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(vertical: 13.5),
      alignment: Alignment.center,
      child: const Text(
        'Contiune',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
