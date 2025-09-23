import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_exploration/Advanced%20Animation%20Chain/views/loading_dots_view.dart';

import 'interactive_dismissible_lists/views/tasks_view.dart';
import 'interactive_physics_widget/views/drag_drop_view.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeView());
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Widget Exploration')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildItem(context, 'Interactive Dismissible Lists', TasksView()),
            _buildItem(context, 'Interactive Physics Widget', DragDropView()),
            _buildItem(context, 'Advanced Animation Chain', LoadingDotsView()),
          ],
        ),
      ),
    );
  }

  _buildItem(BuildContext context, String title, Widget page) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
