import 'package:go_router/go_router.dart';

import '../../features/splash/splash_view.dart';

abstract class AppRouter {
  static const splash = '/';

  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
    ],
  );
}
