import 'package:flutter/material.dart';

class AnimatedCrossFadeDemo extends StatefulWidget {
  const AnimatedCrossFadeDemo({super.key});

  @override
  State<AnimatedCrossFadeDemo> createState() => _AnimatedCrossFadeDemoState();
}

class _AnimatedCrossFadeDemoState extends State<AnimatedCrossFadeDemo> {
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AnimatedCrossFade Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              duration: const Duration(seconds: 1),
              firstChild: Container(
                width: 150,
                height: 150,
                color: Colors.orange,
                child: const Center(child: Text("First")),
              ),
              secondChild: Container(
                width: 150,
                height: 150,
                color: Colors.green,
                child: const Center(child: Text("Second")),
              ),
              crossFadeState: _showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _showFirst = !_showFirst),
              child: const Text("Toggle"),
            ),
          ],
        ),
      ),
    );
  }
}
