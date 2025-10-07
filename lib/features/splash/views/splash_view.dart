import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/theme_extension.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.go(AppRouter.welcome);
    });
  }

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
