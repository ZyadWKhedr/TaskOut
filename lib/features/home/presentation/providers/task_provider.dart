import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_out/features/home/data/database/database_helper.dart';
import 'package:task_out/features/home/data/models/task_model.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  final _dbHelper = DatabaseHelper();

  TaskListNotifier() : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final tasks = await _dbHelper.getTasks();
    state = tasks;
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    state = [...state, task];
  }

  Future<void> deleteTask(String taskId) async {
    await _dbHelper.deleteTask(taskId);
    state = state.where((task) => task.id != taskId).toList();
  }

  Future<void> updateTask(Task updatedTask) async {
    await _dbHelper.updateTask(updatedTask);
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task,
    ];
  }
}
