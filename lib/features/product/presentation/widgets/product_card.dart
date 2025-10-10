import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/product.dart';
import 'custom_card.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = (product.discountPercentage ?? 0) > 0;
    final double discountedPrice =
        product.price * (1 - (product.discountPercentage ?? 0) / 100);

    return CustomCard(
      onTap: () {
        context.push('/product/${product.id}');
      },
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildProductImage(),
                _buildFavoriteButton(),
                if (hasDiscount) _buildDiscountBadge(),
              ],
            ),
          ),
          _buildProductInfo(hasDiscount, discountedPrice),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Image.network(
      product.coverPictureUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error, color: AppColors.secondaryText);
      },
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.favorite_border,
          color: AppColors.secondaryText,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          '-${product.discountPercentage}%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo(bool hasDiscount, double discountedPrice) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.primaryTextLight,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          _buildRatingInfo(),
          const SizedBox(height: 8),
          _buildPriceInfo(hasDiscount, discountedPrice),
        ],
      ),
    );
  }

  Widget _buildRatingInfo() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        Text(
          '${product.rating} (${product.reviewsCount})',
          style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
        ),
      ],
    );
  }

  Widget _buildPriceInfo(bool hasDiscount, double discountedPrice) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '\$${discountedPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.primaryLight,
          ),
        ),
        if (hasDiscount)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: AppColors.secondaryText,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
      ],
    );
  }
}
