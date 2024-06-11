import 'package:flutter/material.dart';
import 'package:task_manager/models/tasks_model.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/services/local_storage_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  final LocalStorageService _localStorageService = LocalStorageService();

  TaskProvider() {
    fetchAllTasks(); // Default fetch on initialization
  }

  Future<void> fetchTasks(int limit, int skip) async {
    try {
      _isLoading = true;
      notifyListeners();
      // Load tasks from local storage first
      List<Task> localTasks = await _localStorageService.getTasks();
      if (localTasks.isNotEmpty) {
        _tasks = localTasks;
        print('local task');
        _isLoading = false;
        notifyListeners();
        return;
      }

      // If no local tasks, fetch from API
      _tasks = await TaskService().fetchTasks(limit, skip);
      await _localStorageService
          .saveTasks(_tasks); // Save fetched tasks to local storage
    } catch (e) {
      // Handle error
      print('Failed to fetch tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllTasks() async {
    try {
      _isLoading = true;
      notifyListeners();
      // Load tasks from local storage first
      List<Task> localTasks = await _localStorageService.getTasks();
      if (localTasks.isNotEmpty) {
        _tasks = localTasks;
        _isLoading = false;
        print('local task');
        notifyListeners();
        return;
      }
      // If no local tasks, fetch from API
      _tasks = await TaskService().fetchallTasks();
      await _localStorageService
          .saveTasks(_tasks); // Save fetched tasks to local storage
      print('server task');
    } catch (e) {
      // Handle error
      print('Failed to fetch tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(Task task) async {
    try {
      Task addedTask = await TaskService().addTask(task);
      _tasks.add(addedTask);
      notifyListeners();
      // Save the updated list to local storage
      await _localStorageService.saveTasks(_tasks);
    } catch (e) {
      // Remove the optimistically added task if the API call fail
      notifyListeners();
      print('Failed in task_provider : $e');
    }
  }

Future<void> editTask(Task task) async {
  try {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      // Optimistically update the task in the UI
      _tasks[index] = task;
      notifyListeners();

      // Update the task in the external service
      Task updatedTask = await TaskService().editTask(task);

      // Update the task in local storage
      await _localStorageService.editTask(updatedTask);

      // Optionally, save the entire list to local storage
      await _localStorageService.saveTasks(_tasks);
    }
  } catch (e) {
    // Log the error
    print('Failed to edit task: $e');
  }
}

 Future<void> deleteTask(Task deleteTask) async {
    try {
      // Optimistic UI update
      _tasks.removeWhere((task) => task.id == deleteTask.id);
      await LocalStorageService().removeTask(deleteTask.id!);
      notifyListeners();
      // Delete from the external service
      // await TaskService().deleteTask(deleteTask.id!);
      print('Task successfully deleted.');
    } catch (e) {
      print('Failed to delete task: $e'); // Log the error
      _tasks.add(deleteTask);
      notifyListeners();
      print('Task deletion reverted due to error.');
    }
  }
}
