import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/category/${category.id}');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (category.coverPictureUrl != null)
                Expanded(
                  child: SvgPicture.network(
                    category.coverPictureUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              Text(category.name),
            ],
          ),
        ),
      ),
    );
  }
}
