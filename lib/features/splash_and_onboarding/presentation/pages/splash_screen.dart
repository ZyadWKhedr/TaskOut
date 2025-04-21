import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_out/features/splash_and_onboarding/presentation/provider/on_boarding_provider.dart';
import 'package:task_out/routes/routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _navigationCompleted = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    if (_navigationCompleted) return;

    // Wait for animations to complete
    await Future.delayed(const Duration(seconds: 2));

    // Get the current state of auth provider
    ref.read(authStateProvider.notifier);
    final currentAuthState = ref.read(authStateProvider);

    if (currentAuthState.isLoading) {}

    // Check both providers
    final isFirstTime = await ref.read(isFirstTimeProvider.future);
    final refreshedAuthState = ref.read(authStateProvider);

    refreshedAuthState.when(
      data: (user) {
        _navigationCompleted = true;
        if (isFirstTime) {
          context.pushReplacement(AppRoutes.onboarding);
        } else {
          context.pushReplacement(
            user != null ? AppRoutes.home : AppRoutes.auth,
          );
        }
      },
      loading: () {
        _navigationCompleted = true;
        context.pushReplacement(AppRoutes.auth);
      },
      error: (error, stack) {
        _navigationCompleted = true;
        context.pushReplacement(
          isFirstTime ? AppRoutes.onboarding : AppRoutes.auth,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TASKOUT',
                  style: TextStyle(
                    fontSize: AppSizes.textXl * 2.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 4.0,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Get Things Done',
                  style: TextStyle(
                    fontSize: AppSizes.textLg,
                    color: Colors.white.withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: AppSizes.blockWidth * 20,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
