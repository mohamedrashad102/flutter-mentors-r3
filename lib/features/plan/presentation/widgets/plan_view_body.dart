import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_images.dart';
import 'plan_card_section.dart';
import 'plan_continue_button.dart';
import 'plan_header.dart';
import 'plan_rocket_image.dart';
import 'plan_seamless_anime.dart';

class PlanViewBody extends StatelessWidget {
  const PlanViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFDDE2FF), Color(0xFFFFFFFF)],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 175,
            right: -14,
            child: Image.asset(AppImages.planRightStar),
          ),
          Positioned(
            top: 0,
            left: -14,
            child: Image.asset(AppImages.planLeftStar),
          ),
          const SafeArea(
            bottom: false,
            child: Column(
              children: [
                Gap(20),
                PlanHeader(),
                Gap(9),
                PlanRocketImage(),
                Gap(4),
                PlanSeamlessAnime(),
                Gap(30),
                PlanCardSection(),
                Gap(39),
                PlanContinueButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
