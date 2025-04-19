import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:task_out/features/auth/presentation/pages/auth_page.dart';
import 'package:task_out/features/auth/presentation/pages/login_page.dart';
import 'package:task_out/features/splash_and_onboarding/presentation/pages/on_boarding_page.dart';
import 'package:task_out/features/splash_and_onboarding/presentation/pages/splash_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder:
          (context, state) => buildFadeTransitionPage(
            child: SplashScreen(),
            key: state.pageKey,
          ),
    ),
    GoRoute(path: '/onboarding', builder: (context, state) => OnboardingPage()),
    GoRoute(
      path: '/auth',
      pageBuilder:
          (context, state) =>
              buildFadeTransitionPage(child: AuthPage(), key: state.pageKey),
    ),
    GoRoute(
      path: '/login',
      pageBuilder:
          (context, state) =>
              buildFadeTransitionPage(child: LoginPage(), key: state.pageKey),
    ),
    GoRoute(
      path: '/register',
      pageBuilder:
          (context, state) =>
              buildFadeTransitionPage(child: AuthPage(), key: state.pageKey),
    ),
  ],
);

CustomTransitionPage buildFadeTransitionPage({
  required Widget child,
  required LocalKey key,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
