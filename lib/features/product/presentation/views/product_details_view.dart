import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubits/product_details_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  final String id;

  const ProductDetailsView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<ProductDetailsCubit>()..fetchProductDetails(id),
      child: Scaffold(
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        product.coverPictureUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 5),
                              Text(
                                '${product.rating} (${product.reviewsCount} reviews)',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            product.description,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${product.price}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryLight,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (product.color != null)
                            _buildDetailRow('Color', product.color!),
                          if (product.stock > 0)
                            _buildDetailRow('In Stock', 'Yes')
                          else
                            _buildDetailRow('In Stock', 'No'),
                          if (product.discountPercentage != null)
                            _buildDetailRow(
                              'Discount',
                              '${product.discountPercentage}%',
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomButton(onPressed: () {}, text: 'Add to Cart'),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.secondaryText,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
