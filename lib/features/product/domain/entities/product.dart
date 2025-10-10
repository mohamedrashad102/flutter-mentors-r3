import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String? productCode;
  final String name;
  final String description;
  final String? arabicName;
  final String? arabicDescription;
  final String coverPictureUrl;
  final List<String>? productPictures;
  final double price;
  final int stock;
  final double? weight;
  final String? color;
  final double rating;
  final int reviewsCount;
  final double? discountPercentage;
  final String? sellerId;
  final List<String> categories;

  const Product({
    required this.id,
    this.productCode,
    required this.name,
    required this.description,
    this.arabicName,
    this.arabicDescription,
    required this.coverPictureUrl,
    this.productPictures,
    required this.price,
    required this.stock,
    this.weight,
    this.color,
    required this.rating,
    required this.reviewsCount,
    this.discountPercentage,
    this.sellerId,
    required this.categories,
  });

  @override
  List<Object?> get props => [
    id,
    productCode,
    name,
    description,
    arabicName,
    arabicDescription,
    coverPictureUrl,
    productPictures,
    price,
    stock,
    weight,
    color,
    rating,
    reviewsCount,
    discountPercentage,
    sellerId,
    categories,
  ];
}
