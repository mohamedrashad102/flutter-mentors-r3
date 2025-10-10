import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/app_colors.dart';

class ProductImageGallery extends StatefulWidget {
  final List<String> imageUrls;

  const ProductImageGallery({super.key, required this.imageUrls});

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildImagePager(),
        _buildPagerIndicator(),
      ],
    );
  }

  Widget _buildImagePager() {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imageUrls.length,
      itemBuilder: (context, index) {
        return Image.network(
          widget.imageUrls[index],
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: AppColors.secondaryText);
          },
        );
      },
    );
  }

  Widget _buildPagerIndicator() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: widget.imageUrls.length,
        effect: const WormEffect(
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: AppColors.primaryLight,
          dotColor: Colors.white,
        ),
      ),
    );
  }
}
