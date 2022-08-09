import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Categories {
  Categories({
    required this.categories,
  });
  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
  final List<Category> categories;
}

@JsonSerializable()
class Category {
  Category({
    required this.id,
    required this.name,
    required this.color,
    required this.createdAt,
    this.deletedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
  final String id;
  final String name;
  final String color;
  final String createdAt;
  final String? deletedAt;
}
