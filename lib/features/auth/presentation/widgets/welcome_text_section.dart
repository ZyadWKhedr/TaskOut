import 'package:flutter/material.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/widgets/custom_text_widget.dart';

class WelcomeTextSection extends StatelessWidget {
  final String title;
  final String message;
  final String actionText;
  final VoidCallback onActionTap;

  const WelcomeTextSection({
    super.key,
    required this.title,
    required this.message,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
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
                TextSpan(text: message),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: onActionTap,
                    child: Text(
                      actionText,
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
