import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_router.dart';
import '../../auth/data/datasources/local_auth_data_source.dart';

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
      final isLogin = di<LocalAuthDataSource>().isLogin;
      if (isLogin) {
        context.go(AppRouter.home);
      } else {
        context.go(AppRouter.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Center(
        child: Image.asset(AppAssets.imagesLogo, color: AppColors.logoLight),
      ),
    );
  }
}
