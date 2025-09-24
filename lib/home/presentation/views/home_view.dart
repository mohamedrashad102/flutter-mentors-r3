import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/home_header.dart';
import '../widgets/home_posters.dart';
import '../widgets/home_taps.dart';
import '../widgets/home_top_characters.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              child: Image.asset('assets/images/star1.png'),
            ),
            const SafeArea(
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
      ),
    );
  }
}
