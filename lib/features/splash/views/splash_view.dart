import 'package:flutter/material.dart';

import '../../../core/extensions/theme_extension.dart';
import '../../../core/utils/app_assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.primaryColor,
      body: Center(
        child: Image.asset(
          AppAssets.imagesLogo,
          color: context.theme.logoColor,
        ),
      ),
    );
  }
}
