import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_out/features/home/data/models/task_model.dart';
import 'package:task_out/features/home/presentation/providers/category_list_provider.dart';
import 'package:task_out/features/home/presentation/providers/task_provider.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class AddTaskForm extends ConsumerStatefulWidget {
  const AddTaskForm({super.key});

  @override
  ConsumerState<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends ConsumerState<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedPriority;
  String? selectedCategory;
  XFile? selectedImage;

  final List<String> priorities = ['High', 'Medium', 'Low'];

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryListProvider);

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
                'Enter Your Task Details',
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
                  hintText: 'ex: do math homework',
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
                  hintText: 'ex: Math Homework',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text('Priority'),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items:
                    priorities.map((priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPriority = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('Category'),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items:
                    categories.map((category) {
                      return DropdownMenuItem(
                        value: category.title,
                        child: Text(category.title),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('Image'),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: selectedImage?.name ?? 'No image selected',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final picked = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (picked != null) {
                        setState(() {
                          selectedImage = picked;
                        });
                      }
                    },
                    icon: const Icon(Icons.upload),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final newTask = Task(
                            id: DateTime.now().toString(),
                            title: titleController.text,
                            description: descriptionController.text,
                            priority: selectedPriority ?? 'Low',
                            category: selectedCategory ?? 'General',
                            imagePath: selectedImage?.path,
                          );

                          ref.read(taskListProvider.notifier).addTask(newTask);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Create Task'),
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
