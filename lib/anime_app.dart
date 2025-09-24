import 'package:flutter/material.dart';

import 'features/plan/presentation/views/plan_view.dart';

class AnimeApp extends StatelessWidget {
  const AnimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Raleway'),
      home: const PlanView(),
    );
  }
}
