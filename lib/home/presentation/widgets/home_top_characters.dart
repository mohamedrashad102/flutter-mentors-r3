import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
          height: 143,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  CircleAvatar(radius: 46),
                  Text(
                    'Gon Freecss',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF18153F),
                    ),
                  ),
                  Text(
                    'Hunter x Hunter',
                    style: TextStyle(
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
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
