import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_manager/models/tasks_model.dart';

class TaskService {
  Future<List<Task>> fetchTasks(int limit, int skip) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/todos?limit=$limit&skip=$skip'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final todos = data['todos'] as List;
      return todos.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<List<Task>> fetchallTasks() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/todos'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final todos = data['todos'] as List;
      print(todos);
      return todos.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }


  Future<Task> addTask(Task task) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/todos/add'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(task),
    );

    if (response.statusCode == 201) {
      // Successfully added task, parse the response body
      print('added response: ${response.body}');
      return Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      print('Failed to add task, status code: ${response.statusCode}');
      throw Exception('Failed in task service task');
    }
  }

  Future<Task> editTask(Task task) async {
    final response = await http.put(
      Uri.parse('https://dummyjson.com/todos/${task.id}'),
      body: jsonEncode({'completed': task.completed}),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print('edit response: ${response.body}');
      return Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to edit task here in api call');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('https://dummyjson.com/todos/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
