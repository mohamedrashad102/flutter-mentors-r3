import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../providers/characters_provider.dart';

class HomeTopCharacters extends StatelessWidget {
  const HomeTopCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Characters',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Gap(24),
        SizedBox(
          height: 160,
          child: Consumer(
            builder: (context, ref, child) {
              final characters = ref.watch(charactersProvider);
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(character.image),
                      ),
                      const Gap(10),
                      Text(
                        character.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkColor,
                        ),
                      ),
                      const Gap(6),
                      Text(
                        character.series,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFFACACAC),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Gap(12);
                },
                itemCount: characters.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
