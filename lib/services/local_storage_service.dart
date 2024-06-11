import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/tasks_model.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _tasksKey = 'tasks';
  static const String _tokenKey = 'auth_token';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksString =
        jsonEncode(tasks.map((task) => task.toMap()).toList());
    await prefs.setString(_tasksKey, tasksString);
  }

  Future<void> removeTask(int taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString(_tasksKey);

    if (tasksString != null) {
      List<Map<String, dynamic>> taskMaps =
          List<Map<String, dynamic>>.from(jsonDecode(tasksString));
      taskMaps.removeWhere((taskMap) => taskMap['id'] == taskId);
      final String updatedTasksString = jsonEncode(taskMaps);
      await prefs.setString(_tasksKey, updatedTasksString);
    }
  }

  Future<void> editTask(Task updatedTask) async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString(_tasksKey);
    if (tasksString != null) {
      List<Map<String, dynamic>> taskMaps =
          List<Map<String, dynamic>>.from(jsonDecode(tasksString));
      int index =
          taskMaps.indexWhere((taskMap) => taskMap['id'] == updatedTask.id);
      if (index != -1) {
        taskMaps[index] = updatedTask.toMap();
        final String updatedTasksString = jsonEncode(taskMaps);
        await prefs.setString(_tasksKey, updatedTasksString);
      }
    }
  }

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString(_tasksKey);

    if (tasksString != null) {
      List<Map<String, dynamic>> taskMaps =
          List<Map<String, dynamic>>.from(jsonDecode(tasksString));
      return taskMaps.map((taskMap) => Task.fromMap(taskMap)).toList();
    } else {
      return [];
    }
  }

  Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tasksKey);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tasksKey);
    await prefs.remove(_tokenKey);
  }

  Future<void> logout() async {
    await LocalStorageService().clearData();
  }
}
