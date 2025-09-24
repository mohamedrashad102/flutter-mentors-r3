import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_colors.dart';
import '../providers/home_taps_provider.dart';

class HomeTaps extends ConsumerWidget {
  const HomeTaps({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTapIndex = ref.watch(homeTapsProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: HomeTapsNotifier.taps
            .asMap()
            .entries
            .map(
              (e) => GestureDetector(
                onTap: () {
                  ref.read(homeTapsProvider.notifier).updateIndex(e.key);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    right: e.value == HomeTapsNotifier.taps.last ? 0 : 4,
                  ),
                  decoration: BoxDecoration(
                    color: currentTapIndex.isCurrentIndex(e.key)
                        ? AppColors.primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(
                    e.value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: currentTapIndex.isCurrentIndex(e.key)
                          ? Colors.white
                          : AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
