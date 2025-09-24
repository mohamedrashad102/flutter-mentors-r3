import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Where Anime Comes Alive',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.darkColor,
      ),
    );
  }
}
