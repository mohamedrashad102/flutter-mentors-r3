import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/category.dart';
import '../cubits/home_cubit.dart';
import 'category_card.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all categories
              },
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is HomeLoaded || current is HomeLoading,
          builder: (context, state) {
            if (state is HomeLoaded) {
              return _buildCategoriesList(state.categories);
            }
            return const SizedBox(
              height: 110,
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoriesList(List<Category> categories) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(category: category);
        },
      ),
    );
  }
}
