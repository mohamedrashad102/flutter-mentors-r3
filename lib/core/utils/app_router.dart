import 'package:go_router/go_router.dart';

import '../../features/auth/views/get_started_view.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/splash/views/welcome_view.dart';

abstract class AppRouter {
  static const splash = '/';
  static const welcome = '/welcome';
  static const getStarted = '/get-started';

  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
      GoRoute(path: welcome, builder: (context, state) => const WelcomeView()),
      GoRoute(
        path: getStarted,
        builder: (context, state) => const GetStartedView(),
      ),
    ],
  );
}
