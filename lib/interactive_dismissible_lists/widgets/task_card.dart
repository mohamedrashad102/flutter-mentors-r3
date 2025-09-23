import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_exploration/interactive_dismissible_lists/providers/tasks_provider.dart';

import '../models/task.dart';

class TaskCard extends ConsumerWidget {
  const TaskCard({super.key, required this.task, required this.index});

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksNotifier = ref.read(tasksProvider.notifier);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Dismissible(
      key: ValueKey(task.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        final isConfirmed = await _showDeleteDialog(context);
        if (isConfirmed == true) {
          tasksNotifier.remove(index);
          _showUndoSnackBar(scaffoldMessenger, tasksNotifier, task, index);
        }
        return isConfirmed;
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: const Icon(Icons.drag_handle),
              ),
              const SizedBox(width: 8),
              Text(
                task.title,
                style: TextStyle(
                  decoration: task.done ? TextDecoration.lineThrough : null,
                ),
              ),
              const Spacer(),
              Checkbox(
                value: task.done,
                onChanged: (value) => tasksNotifier.toggleDone(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  void _showUndoSnackBar(
    ScaffoldMessengerState scaffoldMessenger,
    TasksNotifier notifier,
    Task task,
    int index,
  ) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('Task "${task.title}" deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            notifier.insert(index, task);
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
