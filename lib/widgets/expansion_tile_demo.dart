import 'package:flutter/material.dart';

class ExpansionTileDemo extends StatelessWidget {
  const ExpansionTileDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ExpansionTile Demo")),
      body: ListView(
        children: const [
          ExpansionTile(
            title: Text("Fruits"),
            children: [
              ListTile(title: Text("Apple")),
              ListTile(title: Text("Banana")),
            ],
          ),
          ExpansionTile(
            title: Text("Vegetables"),
            children: [
              ListTile(title: Text("Carrot")),
              ListTile(title: Text("Potato")),
            ],
          ),
        ],
      ),
    );
  }
}
