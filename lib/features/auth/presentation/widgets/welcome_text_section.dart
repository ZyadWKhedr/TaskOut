import 'package:flutter/material.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/widgets/custom_text_widget.dart';

class WelcomeTextSection extends StatelessWidget {
  final VoidCallback onSignUpTap;

  const WelcomeTextSection({super.key, required this.onSignUpTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Welcome back!',
            fontSize: AppSizes.textLg * 1.4,
            color: AppColors.mainColor,
            fontWeight: FontWeight.bold,
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: AppSizes.textSm,
                fontWeight: FontWeight.w600,
                color: AppColors.mainColor,
              ),
              children: [
                const TextSpan(text: 'Login below or '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: onSignUpTap,
                    child: Text(
                      'create an account',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: AppSizes.textSm * 1.23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
