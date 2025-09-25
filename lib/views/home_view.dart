import 'package:flutter/material.dart';
import 'package:widget_catalog_app/widgets/animated_cross_fade_demo.dart';
import 'package:widget_catalog_app/widgets/shader_mask_demo.dart';
import 'package:widget_catalog_app/widgets/draggable_sheet_demo.dart';
import 'package:widget_catalog_app/widgets/expansion_tile_demo.dart';
import 'package:widget_catalog_app/widgets/stepper_demo.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final demos = [
      {'title': 'ExpansionTile Demo', 'widget': const ExpansionTileDemo()},
      {'title': 'Stepper Demo', 'widget': const StepperDemo()},
      {
        'title': 'DraggableScrollableSheet Demo',
        'widget': const DraggableSheetDemo(),
      },
      {
        'title': 'AnimatedCrossFade Demo',
        'widget': const AnimatedCrossFadeDemo(),
      },
      {'title': 'ShaderMask Demo', 'widget': const ShaderMaskDemo()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Widget Catalog')),
      body: ListView.builder(
        itemCount: demos.length,
        itemBuilder: (context, index) {
          final demo = demos[index];
          return ListTile(
            title: Text(demo['title'] as String),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => demo['widget'] as Widget),
              );
            },
          );
        },
      ),
    );
  }
}
