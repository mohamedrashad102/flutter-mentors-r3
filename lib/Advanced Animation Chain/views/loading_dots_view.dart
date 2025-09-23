import 'package:flutter/material.dart';
import 'package:flutter_widget_exploration/Advanced%20Animation%20Chain/widgets/loading_dots.dart';

class LoadingDotsView extends StatelessWidget {
  const LoadingDotsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Animation Chain'),
        centerTitle: true,
      ),
      body: Center(child: LoadingDots()),
    );
  }
}
