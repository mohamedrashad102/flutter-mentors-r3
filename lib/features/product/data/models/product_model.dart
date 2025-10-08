import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    super.productCode,
    required super.name,
    required super.description,
    super.arabicName,
    super.arabicDescription,
    required super.coverPictureUrl,
    super.productPictures,
    required super.price,
    required super.stock,
    super.weight,
    super.color,
    required super.rating,
    required super.reviewsCount,
    super.discountPercentage,
    super.sellerId,
    required super.categories,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productCode: json['productCode'],
      name: json['name'],
      description: json['description'],
      arabicName: json['arabicName'] ?? json['nameArabic'],
      arabicDescription: json['arabicDescription'] ?? json['descriptionArabic'],
      coverPictureUrl: json['coverPictureUrl'],
      productPictures: json['productPictures'] != null
          ? List<String>.from(json['productPictures'])
          : null,
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      weight: (json['weight'] as num?)?.toDouble(),
      color: json['color'],
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'],
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      sellerId: json['sellerId'],
      categories: List<String>.from(json['categories']),
    );
  }
}
