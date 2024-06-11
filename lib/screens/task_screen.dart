import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/screens/add_task.dart';
import 'package:task_manager/screens/edit_task.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/services/local_storage_service.dart';
import 'package:task_manager/utils/constants.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: AppTextStyles.appBarButton,
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await LocalStorageService().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) =>
                    false, // This prevents going back to the previous screen
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            label: const Text(
              'Logout',
              style: AppTextStyles.logoutText,
            ),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.tasks[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        task.todo,
                        style: AppTextStyles.taskTitle,
                      ),
                      subtitle: Text(
                        task.completed ? 'Completed' : 'Pending',
                        style: task.completed
                            ? AppTextStyles.taskCompleted
                            : AppTextStyles.taskIncomplete,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              taskProvider.deleteTask(task);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditTaskScreen(task: task),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

