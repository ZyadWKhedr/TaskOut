import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_out/core/services/prefrences_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = LiquidController();
  int currentPage = 0;

  final pages = [
    Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          "Welcome!",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    ),
    Container(
      color: Colors.green,
      child: Center(
        child: Text(
          "Explore!",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    ),
    Container(
      color: Colors.purple,
      child: Center(
        child: Text(
          "Get Started!",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    ),
  ];

  void onDone() async {
    await PreferencesService().setOnboardingComplete();
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            onPageChangeCallback:
                (index) => setState(() => currentPage = index),
            liquidController: controller,
            enableLoop: true,
            waveType: WaveType.liquidReveal,
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AnimatedSmoothIndicator(
                  activeIndex: currentPage,
                  count: pages.length,
                  effect: WormEffect(
                    dotColor: Colors.white54,
                    activeDotColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                if (currentPage == pages.length - 1)
                  ElevatedButton(onPressed: onDone, child: Text("Get Started")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}