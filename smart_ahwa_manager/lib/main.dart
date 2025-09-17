import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/coffee_theme.dart';
import 'views/app_shell.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ahwa Manager',
      debugShowCheckedModeBanner: false,
      theme: CoffeeTheme.theme,
      home: const AppShell(),
    );
  }
}
