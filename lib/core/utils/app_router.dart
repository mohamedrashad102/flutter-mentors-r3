import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/register_view.dart';
import '../../features/auth/presentation/view/verify_email_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/splash/views/welcome_view.dart';

abstract class AppRouter {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const verifyEmail = '/verify-email';
  static const home = '/home';

  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
      GoRoute(path: welcome, builder: (context, state) => const WelcomeView()),
      GoRoute(path: login, builder: (context, state) => const LoginPage()),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: verifyEmail,
        builder: (context, state) {
          final email = state.extra as String;
          return VerifyEmailPage(email: email);
        },
      ),
      GoRoute(path: home, builder: (context, state) => const HomeView()),
    ],
  );
}
