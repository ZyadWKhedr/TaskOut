import 'package:flutter/material.dart';
import 'package:task_out/features/splash_and_onboarding/presentation/pages/on_boarding_page.dart';
import 'package:task_out/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OnboardingPage());
    // return MaterialApp.router(
    //   routerConfig: router,
    // );
  }
}
