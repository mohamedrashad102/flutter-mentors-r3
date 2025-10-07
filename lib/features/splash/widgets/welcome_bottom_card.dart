import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/extensions/theme_extension.dart';
import 'gender_selection.dart';

class WelcomeBottomCard extends StatelessWidget {
  const WelcomeBottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 244,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.theme.cardBgColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Look Good, Feel Good',
            style: TextStyle(
              color: context.theme.primaryTextColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              height: 1.10,
              letterSpacing: -0.19,
            ),
          ),
          const Gap(10),
          Text(
            'Create your individual & unique style and look amazing everyday.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.theme.primaryTextColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.40,
            ),
          ),
          const Gap(20),
          const GenderSelection(),
          const Gap(20),
          const Text(
            'Skip',
            style: TextStyle(
              color: Color(0xFF8F959E),
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 1.10,
            ),
          ),
        ],
      ),
    );
  }
}
