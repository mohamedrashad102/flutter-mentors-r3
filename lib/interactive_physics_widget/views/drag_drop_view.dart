import 'package:flutter/material.dart';
import 'package:flutter_widget_exploration/interactive_physics_widget/widgets/drag_drop_game.dart';

class DragDropView extends StatelessWidget {
  const DragDropView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Interactive Physics Widget")),
      body: DragDropGame(),
    );
  }
}
