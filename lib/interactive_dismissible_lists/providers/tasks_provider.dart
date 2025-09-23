import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';

final tasksProvider = NotifierProvider<TasksNotifier, List<Task>>(
  () => TasksNotifier(),
);

class TasksNotifier extends Notifier<List<Task>> {
  @override
  build() {
    return [
      Task(title: 'Task 1', done: false),
      Task(title: 'Task 2', done: false),
      Task(title: 'Task 3', done: false),
      Task(title: 'Task 4', done: false),
      Task(title: 'Task 5', done: false),
    ];
  }

  void reorder(int oldIndex, int newIndex) {
    final direction = newIndex < oldIndex ? 0 : -1;
    state = List.from(state)
      ..removeAt(oldIndex)
      ..insert(newIndex + direction, state[oldIndex]);
  }

  void remove(int index) {
    state = List.from(state)..removeAt(index);
  }

  void toggleDone(int index) {
    state = List.from(state)
      ..[index] = state[index].copyWith(done: !state[index].done);
  }

  void insert(int index, Task task) {
    state = List.from(state)..insert(index, task);
  }
}
