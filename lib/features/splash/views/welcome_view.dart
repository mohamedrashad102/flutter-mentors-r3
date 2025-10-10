import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_assets.dart';
import '../widgets/welcome_bottom_card.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.gradientBgLight),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.imagesWelcomeMan),
            const Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: WelcomeBottomCard(),
            ),
          ],
        ),
      ),
    );
  }
}
