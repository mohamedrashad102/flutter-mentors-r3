import 'package:flutter/material.dart';

class DraggableSheetDemo extends StatelessWidget {
  const DraggableSheetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DraggableScrollableSheet Demo")),
      body: Stack(
        children: [
          const Center(child: Text("Swipe up from bottom")),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (context, index) =>
                      ListTile(title: Text("Item ${index + 1}")),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
