import 'package:flutter/material.dart';
import '../../../../core/utils/app_images.dart';

class ImageHero extends StatelessWidget {
  const ImageHero({super.key});
  static const double height = 519;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Image.asset(AppImages.heroImage, fit: BoxFit.cover),
    );
  }
}
