import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../cubits/category_products_cubit.dart';
import '../widgets/product_card.dart';

class CategoryProductsView extends StatelessWidget {
  final String categoryId;

  const CategoryProductsView({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<CategoryProductsCubit>()..fetchInitialProducts(categoryId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
          builder: (context, state) {
            if (state is CategoryProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryProductsError) {
              return Center(child: Text(state.message));
            } else if (state is CategoryProductsLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(20.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: state.hasReachedMax
                    ? state.products.length
                    : state.products.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.products.length) {
                    context.read<CategoryProductsCubit>().fetchMoreProducts();
                    return const Center(child: CircularProgressIndicator());
                  }
                  final product = state.products[index];
                  return ProductCard(product: product);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
