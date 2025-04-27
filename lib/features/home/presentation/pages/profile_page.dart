import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_out/features/auth/domain/entities/user_entity.dart';
import 'package:task_out/routes/routes.dart';

class ProfilePage extends ConsumerWidget {
  final UserEntity? user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = user?.name ?? 'Guest';
    final email = user?.email ?? 'No email available';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.mainColor.withOpacity(0.2),
              child: Icon(Icons.person, size: 50, color: AppColors.mainColor),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                fontSize: AppSizes.textXl,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(
                fontSize: AppSizes.textSm,
                color: AppColors.mainColor,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Sign Out'),

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(
                    fontSize: AppSizes.textSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  ref.read(authStateProvider.notifier).signOut();
                  context.pushReplacement(AppRoutes.auth);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
