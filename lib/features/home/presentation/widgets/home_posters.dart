import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_transaction.dart';
import '../../../detail/presentation/views/detail_view.dart';
import '../providers/posters_provider.dart';

class HomePosters extends ConsumerWidget {
  const HomePosters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posters = ref.watch(postersProvider);
    return SizedBox(
      height: 295,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          final poster = posters[index];
          return GestureDetector(
            onTap: () {
              AppTransitions.scaleFade(context, const DetailView());
            },
            child: Column(
              children: [
                Container(
                  height: 245,
                  width: 184,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(poster.posterPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(7),
                Text(
                  poster.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkColor,
                  ),
                ),
                const Gap(4),
                Text(
                  poster.type,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFA9A9A9),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const Gap(12),
        itemCount: posters.length,
      ),
    );
  }
}
