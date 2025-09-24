import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';

class PlanSeamlessAnime extends StatelessWidget {
  const PlanSeamlessAnime({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 42 - 14),
      child: Column(
        children: [
          Text(
            'Seamless Anime Experience, Ad-Free.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkColor,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          Gap(4),
          Text(
            'Enjoy unlimited anime streaming without interruptions.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.greyColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
