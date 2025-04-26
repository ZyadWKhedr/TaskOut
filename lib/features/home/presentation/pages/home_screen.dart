import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/core/widgets/custom_text_widget.dart';
import 'package:task_out/features/auth/presentation/providers/auth_provider.dart'; // adjust import path if needed

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        final name = user?.name ?? 'Guest';
        return Padding(
          padding: EdgeInsets.only(
            top: AppSizes.paddingXl * 2,
            left: AppSizes.paddingXl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Welcome, $name',
                    fontSize: AppSizes.textXl,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: AppSizes.blockHeight / 1.9),
                  CustomText(
                    'Hope you\'re having a great day',
                    fontSize: AppSizes.textSm,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: ${error.toString()}')),
    );
  }
}
