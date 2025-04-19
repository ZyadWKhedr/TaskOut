import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/utils/app_sizes.dart';

class CustomBackButtonIcon extends StatelessWidget {
  const CustomBackButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        padding: EdgeInsets.all(AppSizes.paddingSm),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}
