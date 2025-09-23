import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late List<Animation<double>> _scales;
  late List<Animation<double>> _opacities;

  @override
  void initState() {
    super.initState();

    // AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // full cycle
    )..repeat(); // loop forever

    // 3 dots → each one has its own interval (phase shift)
    _scales = List.generate(3, (index) {
      return Tween(begin: 0.5, end: 1.2).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            index * 0.2 + 0.6,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });

    _opacities = List.generate(3, (index) {
      return Tween(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            index * 0.2 + 0.6,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Opacity(
              opacity: _opacities[index].value,
              child: Transform.scale(
                scale: _scales[index].value,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
