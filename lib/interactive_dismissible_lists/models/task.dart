class Task {
  final String title;
  final bool done;
  final int id;

  static int idCounter = 0;

  Task({required this.title, required this.done}) : id = idCounter++;

  Task copyWith({String? title, bool? done}) {
    return Task(title: title ?? this.title, done: done ?? this.done);
  }
}
