// category_list_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_out/features/home/data/database/database_helper.dart';
import 'package:task_out/features/home/data/models/category_model.dart';

final categoryListProvider =
    StateNotifierProvider<CategoryListNotifier, List<Category>>((ref) {
      return CategoryListNotifier();
    });

class CategoryListNotifier extends StateNotifier<List<Category>> {
  final _dbHelper = DatabaseHelper();

  CategoryListNotifier() : super([]) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final categories = await _dbHelper.getCategories();
    state = categories;
  }

  Future<void> addCategory(Category category) async {
    await _dbHelper.insertCategory(category);
    state = [...state, category];
  }
}
