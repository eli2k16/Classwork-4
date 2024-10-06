import 'package:flutter/material.dart';

void main() => runApp(TaskManagerApp());

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // List to store tasks
  List<Task> tasks = [];

  // Controller for the text input
  TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  // Method to add a task
  void addTask(String taskName) {
    if (taskName.isNotEmpty) {
      setState(() {
        tasks.add(Task(name: taskName));
      });
      taskController.clear(); // Clear input field after adding
    }
  }

  // Method to toggle task completion
  void toggleTaskComplete(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  // Method to remove a task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF82A3C4), // Background color of the app
      appBar: AppBar(
        backgroundColor: Colors.grey, // Set AppBar background to gray
        title: Text(
          'Task Manager',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // Make the header bold
          ),
        ),
      ),
      body: Column(
        children: [
          // Input section with extra padding to move it lower
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 70.0, 16.0, 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter task',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, // Make input label bold
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add some space between TextField and button
                ElevatedButton(
                  onPressed: () => addTask(taskController.text),
                  child: Text('Add'), // 'Add' button instead of '+' icon
                ),
              ],
            ),
          ),

          // Task list
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tasks[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Make task names bold
                      decoration: tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (_) => toggleTaskComplete(index),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Task class to hold task information
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
