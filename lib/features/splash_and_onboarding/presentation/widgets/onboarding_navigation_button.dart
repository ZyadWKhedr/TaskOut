import 'package:flutter/material.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/core/extensions/spacing_extension.dart';

class OnboardingNavigationButton extends StatelessWidget {
  final VoidCallback onNext;
  final String leftImage;
  final String rightImage;

  const OnboardingNavigationButton({
    super.key,
    required this.onNext,
    required this.leftImage,
    required this.rightImage,
  });

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          leftImage,
          width: AppSizes.blockWidth * 30,
          height: AppSizes.blockWidth * 30,
        ),
        4.wRel,
        InkWell(
          onTap: onNext,
          borderRadius: BorderRadius.circular(AppSizes.blockWidth * 10),
          child: Container(
            padding: EdgeInsets.all(AppSizes.blockWidth * 6),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: AppColors.backgroundColor,
              size: AppSizes.blockWidth * 8,
            ),
          ),
        ),
        4.wRel,
        Image.asset(
          rightImage,
          width: AppSizes.blockWidth * 30,
          height: AppSizes.blockWidth * 30,
        ),
      ],
    );
  }
}
