import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../cubits/product_details_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  final String id;

  const ProductDetailsView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<ProductDetailsCubit>()..fetchProductDetails(id),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(product.coverPictureUrl),
                    const SizedBox(height: 16.0),
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$${product.price}',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Text(product.description),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(
                          '${product.rating} (${product.reviewsCount} reviews)',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text('Stock: ${product.stock}'),
                    if (product.color != null) ...[
                      const SizedBox(height: 16.0),
                      Text('Color: ${product.color}'),
                    ],
                    if (product.discountPercentage != null) ...[
                      const SizedBox(height: 16.0),
                      Text('Discount: ${product.discountPercentage}%'),
                    ],
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
