import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_out/core/constants/app_assets.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/services/prefrences_service.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/core/extensions/spacing_extension.dart';
import 'package:task_out/core/widgets/custom_text_widget.dart';
import 'package:task_out/features/splash_and_onboarding/presentation/widgets/onboarding_navigation_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = LiquidController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': AppAssets.onboarding1,
      'title': 'Stay Organized, Stay Productive',
      'description':
          'Manage your tasks effortlessly. Plan your day, set reminders, and stay on top of your goals.',
    },
    {
      'image': AppAssets.onboarding2,
      'title': 'Collaborate with Team',
      'description':
          'Share tasks with your team members and work together seamlessly on projects.',
    },
    {
      'image': AppAssets.onboarding3,
      'title': 'Track Your Progress',
      'description':
          'Visualize your achievements and stay motivated with our progress tracking system.',
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppSizes.init(context); // Initialize sizes once context is ready
  }

  Widget _buildOnboardingPage(Map<String, String> data) {
    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data['image']!),
          AppSizes.paddingMd.h,
          AnimatedSmoothIndicator(
            activeIndex: currentPage,
            count: onboardingData.length,
            effect: ScrollingDotsEffect(
              activeDotColor: AppColors.mainColor,
              dotColor: AppColors.secondaryColor,
              dotHeight: AppSizes.blockWidth * 2,
              dotWidth: AppSizes.blockWidth * 6,
              spacing: AppSizes.blockWidth * 2,
            ),
          ),
          AppSizes.paddingMd.h,
          CustomText(
            data['title']!,
            fontSize: AppSizes.textXl,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
            textAlign: TextAlign.center,
          ),
          AppSizes.paddingSm.h,
          CustomText(
            data['description']!,
            fontSize: AppSizes.textMd,
            color: AppColors.mainColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void onDone() async {
    await PreferencesService().setOnboardingComplete();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages:
                onboardingData
                    .map((data) => _buildOnboardingPage(data))
                    .toList(),
            onPageChangeCallback:
                (index) => setState(() => currentPage = index),
            liquidController: controller,
            enableLoop: false,
            waveType: WaveType.circularReveal,
          ),
          Positioned(
            bottom: AppSizes.blockHeight * 5,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (currentPage == onboardingData.length - 1)
                  ElevatedButton(
                    onPressed: onDone,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.blockWidth * 10,
                        vertical: AppSizes.blockHeight * 2.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.blockWidth * 8,
                        ),
                      ),
                    ),
                    child: CustomText(
                      "Get Started",
                      fontSize: AppSizes.textLg,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor,
                    ),
                  )
                else
                  OnboardingNavigationButton(
                    leftImage: AppAssets.leftArrow,
                    rightImage: AppAssets.rightArrow,
                    onNext: () {
                      controller.animateToPage(
                        page: currentPage + 1,
                        duration: 600,
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
