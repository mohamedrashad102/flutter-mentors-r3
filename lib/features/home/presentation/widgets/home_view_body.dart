import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_images.dart';
import 'home_header.dart';
import 'home_posters.dart';
import 'home_taps.dart';
import 'home_top_characters.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

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
            top: 0,
            right: -14,
            child: Image.asset(AppImages.homeStar),
          ),
          const SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(23),
                HomeHeader(),
                Gap(24),
                HomeTaps(),
                Gap(24),
                HomePosters(),
                Gap(20),
                HomeTopCharacters(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
