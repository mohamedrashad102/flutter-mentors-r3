import 'package:flutter/material.dart';
import 'package:provider_challenge/screens/screen_b.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page A')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageB()),
            );
          },
          child: const Text('Go to Page B'),
        ),
      ),
    );
  }
}
