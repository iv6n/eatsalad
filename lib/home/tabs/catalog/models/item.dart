import 'package:equatable/equatable.dart';
//import 'package:uuid/uuid.dart';

class Item extends Equatable {
  const Item({
    this.id,
    this.itemName,
    this.description,
    this.categoryId,
    this.imageUrl,
    this.variants,
    this.newItemId = '',
    this.finalPrice = 0,
    this.ingredients = '',
    this.isCompleted = false,
  });

  ///TODO: set UUID in [id] when id is null

  //loyverse model
  final String? id;
  final String? itemName;
  final String? description;
  final String? categoryId;
  final String? imageUrl;
  final Variant? variants;

  //addition of models
  final String newItemId;
  final double finalPrice;
  final String ingredients;
  final bool isCompleted;

  Item copyWith({
    String? id,
    String? itemName,
    String? description,
    String? categoryId,
    String? imageUrl,
    String? newItemId,
    double? finalPrice,
    String? ingredients,
    bool? isCompleted,
  }) {
    return Item(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      categoryId: categoryId ?? this.categoryId,
      imageUrl: imageUrl ?? this.imageUrl,
      newItemId: newItemId ?? this.newItemId,
      finalPrice: finalPrice ?? this.finalPrice,
      ingredients: ingredients ?? this.ingredients,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        itemName,
        description,
        categoryId,
        imageUrl,
        newItemId,
        finalPrice,
        ingredients,
        isCompleted,
      ];
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
