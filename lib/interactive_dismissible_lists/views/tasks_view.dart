import 'package:flutter/material.dart';
import 'package:flutter_widget_exploration/interactive_dismissible_lists/widgets/tasks_list.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Dismissible Lists')),
      body: Padding(padding: const EdgeInsets.all(8.0), child: TasksList()),
    );
  }
}
