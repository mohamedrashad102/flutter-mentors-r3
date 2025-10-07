import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_router.dart';
import 'gender_selection.dart';

class WelcomeBottomCard extends StatelessWidget {
  const WelcomeBottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 244,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.cardBgLight,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Look Good, Feel Good',
            style: TextStyle(
              color: AppColors.primaryTextLight,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              height: 1.10,
              letterSpacing: -0.19,
            ),
          ),
          const Gap(10),
          const Text(
            'Create your individual & unique style and look amazing everyday.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryTextLight,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.40,
            ),
          ),
          const Gap(20),
          const GenderSelection(),
          const Gap(20),
          InkWell(
            onTap: () {
              context.go(AppRouter.register);
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color(0xFF8F959E),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                height: 1.10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
