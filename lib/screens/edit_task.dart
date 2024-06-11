import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/tasks_model.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/widgets/custom_Button.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _todoController = TextEditingController();
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _todoController.text = widget.task.todo;
    _completed = widget.task.completed;
    print('task id :${widget.task.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task', style: AppTextStyles.appBarButton,),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _todoController,
              style: AppTextStyles.inputText,
              decoration: const InputDecoration(labelText: 'Task description'),
              readOnly: true, // Task description should not be editable
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Completed:'),
                Switch(
                  activeColor:Colors.blue ,
                  activeTrackColor: Colors.blue.shade200,
                  value: _completed,
                  onChanged: (value) {
                    setState(() {
                      _completed = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            CustomButton(
              onPressed: () {
                final updatedTask = Task(
                  id: widget.task.id,
                  todo: widget.task.todo,
                  completed: _completed,
                  userId: widget.task.userId,
                );
                final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                taskProvider.editTask(updatedTask);
                Navigator.pop(context);
              },
              label: 'Update Task',
              backgroundColor: Colors.blue,

            ),
          ],
        ),
      ),
    );
  }
}
