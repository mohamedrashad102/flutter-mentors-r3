import 'package:go_router/go_router.dart';

import '../../features/auth/views/get_started_view.dart';
import '../../features/auth/views/register_view.dart';
import '../../features/auth/views/verify_email_view.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/splash/views/welcome_view.dart';

abstract class AppRouter {
  static const splash = '/';
  static const welcome = '/welcome';
  static const getStarted = '/get-started';
  static const login = '/login';
  static const register = '/register';
  static const verifyEmail = '/verify-email';

  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
      GoRoute(path: welcome, builder: (context, state) => const WelcomeView()),
      GoRoute(
        path: getStarted,
        builder: (context, state) => const GetStartedView(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: verifyEmail,
        builder: (context, state) {
          final email = state.extra as String;
          return VerifyEmailView(email: email);
        },
      ),
    ],
  );
}
