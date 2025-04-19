import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_out/core/constants/app_assets.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/core/widgets/custom_text_widget.dart';
import 'package:task_out/routes/routes.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingSm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.auth),

              SizedBox(height: AppSizes.paddingXl * 1.3),

              // First text
              CustomText(
                'Seamless Collaboration',
                fontSize: AppSizes.textXl * 1.2,
                fontWeight: FontWeight.w500,
                color: AppColors.mainColor,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSizes.paddingSm),

              // Second text
              CustomText(
                'Share tasks, assign responsibilities, and work together with your team.',
                fontSize: AppSizes.textLg * 0.8,
                color: AppColors.mainColor,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSizes.paddingXl * 1.2),

              // Login button (filled)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    padding: EdgeInsets.symmetric(vertical: AppSizes.paddingMd),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.blockWidth * 2,
                      ),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: AppSizes.textMd,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppSizes.paddingMd),

              // Sign up button (outlined)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    context.push(AppRoutes.register);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.mainColor, width: 2.4),
                    padding: EdgeInsets.symmetric(vertical: AppSizes.paddingMd),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.blockWidth * 2,
                      ),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: AppSizes.textMd,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
