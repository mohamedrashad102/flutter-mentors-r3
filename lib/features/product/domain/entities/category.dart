import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? coverPictureUrl;

  const Category({
    required this.id,
    required this.name,
    this.description,
    this.coverPictureUrl,
  });

  @override
  List<Object?> get props => [id, name, description, coverPictureUrl];
}
