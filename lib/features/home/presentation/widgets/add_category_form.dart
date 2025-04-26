import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_out/features/home/data/models/category_model.dart';
import 'package:task_out/features/home/presentation/providers/category_list_provider.dart';
import 'package:task_out/core/constants/app_colors.dart';

class AddCategoryForm extends ConsumerStatefulWidget {
  const AddCategoryForm({super.key});

  @override
  ConsumerState<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends ConsumerState<AddCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Your Category Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
              ),
              const SizedBox(height: 20),
              Text('Title'),
              const SizedBox(height: 5),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'ex: School',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 20),
              Text('Description'),
              const SizedBox(height: 5),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'ex: Tasks related to school work',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final newCategory = Category(
                            id: DateTime.now().toString(),
                            title: titleController.text,
                            description: descriptionController.text,
                          );

                          ref
                              .read(categoryListProvider.notifier)
                              .addCategory(newCategory);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Create Category'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
