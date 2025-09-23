import 'package:flutter/material.dart';

class DragDropGame extends StatefulWidget {
  const DragDropGame({super.key});

  @override
  State<DragDropGame> createState() => _DragDropGameState();
}

class _DragDropGameState extends State<DragDropGame> {
  final List<Color> ballColors = [Colors.red, Colors.green, Colors.blue];

  final Map<Color, bool> matched = {};

  @override
  void initState() {
    super.initState();
    for (var color in ballColors) {
      matched[color] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const ballSize = 45.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ballColors.map((color) {
            return matched[color] == true
                ? const SizedBox(
                    width: ballSize,
                    height: ballSize,
                  ) // hide if matched
                : Draggable<Color>(
                    data: color,
                    feedback: _buildBall(color, ballSize + 2),
                    childWhenDragging: _buildBall(
                      color,
                      ballSize,
                      opacity: 0.4,
                    ),
                    child: _buildBall(color, ballSize),
                  );
          }).toList(),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ballColors.map((color) {
            return DragTarget<Color>(
              onAcceptWithDetails: (data) {
                setState(() {
                  if (data.data == color) {
                    matched[color] = true;
                    _showSnack(context, "Correct!");
                  } else {
                    _showSnack(context, "Wrong container");
                  }
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.6),
                    border: Border.all(color: color, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: matched[color] == true
                      ? Icon(Icons.check, color: Colors.white, size: 40)
                      : (candidateData.isNotEmpty
                            ? Icon(Icons.arrow_downward, color: Colors.white)
                            : null),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBall(Color color, double size, {double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
