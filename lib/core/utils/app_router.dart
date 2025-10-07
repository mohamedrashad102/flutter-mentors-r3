import 'package:go_router/go_router.dart';

import '../../features/splash/views/splash_view.dart';
import '../../features/splash/views/welcome_view.dart';

abstract class AppRouter {
  static const splash = '/';
  static const welcome = '/welcome';

  static final router = GoRouter(
    initialLocation: welcome,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
      GoRoute(path: welcome, builder: (context, state) => const WelcomeView()),
    ],
  );
}
