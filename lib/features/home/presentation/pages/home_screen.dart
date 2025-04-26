import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/core/widgets/custom_text_widget.dart';
import 'package:task_out/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_out/features/home/presentation/providers/task_provider.dart';
import 'package:task_out/features/home/data/models/task_model.dart';
import 'package:task_out/features/home/presentation/widgets/tasks_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final tasks = ref.watch(taskListProvider);

    return authState.when(
      data: (user) {
        final name = user?.name ?? 'Guest';
        return Padding(
          padding: EdgeInsets.only(
            top: AppSizes.paddingXl * 2,
            left: AppSizes.paddingXl,
            right: AppSizes.paddingXl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
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
                  const SizedBox(height: 20),
                ],
              ),

              // Task List section
              Expanded(
                child:
                    tasks.isEmpty
                        ? Center(
                          child: Lottie.asset(
                            'assets/lottie/Animation - 1745673635174.json',
                            width: AppSizes.blockWidth * 150,
                            height: AppSizes.blockWidth * 150,
                          ),
                        )
                        : ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return TaskCard(
                              task: task,
                              onDone: () {
                                _markTaskAsDone(ref, task);
                              },
                              onEdit: () {
                                _editTask(context, ref, task);
                              },
                              onDelete: () {
                                ref
                                    .read(taskListProvider.notifier)
                                    .deleteTask(task.id);
                              },
                            );
                          },
                        ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: ${error.toString()}')),
    );
  }

  void _markTaskAsDone(WidgetRef ref, Task task) {
    final updatedTask = task.copyWith(
      isDone: true,
    ); // Assuming you add 'isDone' field
    ref.read(taskListProvider.notifier).updateTask(updatedTask);
  }

  void _editTask(BuildContext context, WidgetRef ref, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        final titleController = TextEditingController(text: task.title);
        final descController = TextEditingController(text: task.description);

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Edit Task'),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final updatedTask = task.copyWith(
                    title: titleController.text,
                    description: descController.text,
                  );
                  ref.read(taskListProvider.notifier).updateTask(updatedTask);
                  Navigator.pop(context);
                },
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
