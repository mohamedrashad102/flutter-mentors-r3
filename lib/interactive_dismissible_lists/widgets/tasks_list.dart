import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_exploration/interactive_dismissible_lists/providers/tasks_provider.dart';

import 'task_card.dart';

class TasksList extends ConsumerWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);

    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) => TaskCard(
        key: ValueKey(tasks[index].id),
        task: tasks[index],
        index: index,
      ),
      itemCount: tasks.length,
      onReorder: ref.read(tasksProvider.notifier).reorder,
    );
  }
}
