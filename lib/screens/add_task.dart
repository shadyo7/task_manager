import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/tasks_model.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/widgets/custom_Button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task',style: AppTextStyles.appBarButton,),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _todoController,
              style: AppTextStyles.inputText,
              decoration: const InputDecoration(labelText: 'Task description'),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _userIdController,
              style: AppTextStyles.inputText,
              decoration: const InputDecoration(labelText: 'User ID',),
              keyboardType: TextInputType.number,
            ),
             SizedBox(height: 50,),
           CustomButton(
              onPressed: () {
                final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                final task = Task(
                  todo: _todoController.text,
                  completed: false,
                  userId: int.tryParse(_userIdController.text)!,
                );
               taskProvider.addTask(task);
                Navigator.pop(context);
              },
              label: 'Add Task',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
