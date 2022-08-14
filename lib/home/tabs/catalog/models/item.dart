import 'package:equatable/equatable.dart';

class Item extends Equatable {
  const Item(
    this.id,
    this.itemName,
    this.description,
    this.color,
    this.categoryId,
    this.imageUrl,
    this.variants,
  );
  final String id;
  final String itemName;
  final String description;
  final String categoryId;
  final String imageUrl;
  final String color;
  final Variant variants;

  @override
  List<Object?> get props =>
      [id, itemName, description, categoryId, imageUrl, variants];
}

class Variant extends Equatable {
  const Variant(
    this.id,
    this.itemId,
    this.sku,
    this.price,
  );
  final String id;
  final String itemId;
  final String sku;
  final double price;

  @override
  List<Object?> get props => [id, itemId, sku, price];
}
