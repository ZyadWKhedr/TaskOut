import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_out/features/home/presentation/providers/category_list_provider.dart';
import 'package:task_out/core/constants/app_colors.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  // Method to map category name to an icon
  IconData _getCategoryIcon(String name) {
    final icons = [
      Icons.work_outline,
      Icons.school_outlined,
      Icons.shopping_cart_outlined,
      Icons.person_outline,
      Icons.favorite_outline,
      Icons.home_outlined,
      Icons.book_outlined,
      Icons.flight_outlined,
    ];

    // Use the hash code of the category name to select a specific icon
    final hashCode = name.hashCode;
    final iconIndex = hashCode % icons.length; // Ensure it maps within bounds
    return icons[iconIndex];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryListProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:
          categories.isEmpty
              ? const Center(
                child: Text(
                  'No categories yet!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
              : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final categoryIcon = _getCategoryIcon(
                    category.title,
                  ); // Get the icon based on the name

                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.mainColor, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          categoryIcon,
                          size: 40,
                          color: AppColors.mainColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          category.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
