import 'package:json_annotation/json_annotation.dart';

part 'items.g.dart';

@JsonSerializable()
class Items {
  Items({
    required this.items,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);

  final List<Item> items;
}

@JsonSerializable()
class Item {
  Item({
    required this.id,
    this.handle,
    this.itemName,
    this.description,
    this.referenceId,
    this.categoryId,
    this.trackStock,
    this.soldByWeight,
    this.isComposite,
    this.useProduction,
    this.components,
    this.primarySupplierId,
    this.taxIds,
    this.modifiersIds,
    this.form,
    this.color,
    this.imageUrl,
    this.option1Name,
    this.option2Name,
    this.option3Name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.variants,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  final String id;
  final String? handle;
  final String? itemName;
  final String? description;
  final String? referenceId;
  final String? categoryId;
  final bool? trackStock;
  final bool? soldByWeight;
  final bool? isComposite;
  final bool? useProduction;
  final List<Component?>? components;
  final String? primarySupplierId;
  final List<String?>? taxIds;
  final List<String?>? modifiersIds;
  final String? form;
  final String? color;
  final String? imageUrl;
  final String? option1Name;
  final String? option2Name;
  final String? option3Name;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final List<Variant?>? variants;
}

@JsonSerializable()
class Component {
  Component({
    this.variantId,
    this.quantity,
  });

  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);
  Map<String, dynamic> toJson() => _$ComponentToJson(this);

  final String? variantId;
  final int? quantity;
}

@JsonSerializable()
class Variant {
  Variant({
    this.variantId,
    this.itemId,
    this.sku,
    this.referenceVariantId,
    this.option1Value,
    this.option2Value,
    this.option3Value,
    this.barcode,
    this.cost,
    this.purchaseCost,
    this.defaultPricingType,
    this.defaultPrice,
    this.stores,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);
  Map<String, dynamic> toJson() => _$VariantToJson(this);

  final String? variantId;
  final String? itemId;
  final String? sku;
  final String? referenceVariantId;
  final String? option1Value;
  final String? option2Value;
  final String? option3Value;
  final String? barcode;
  final double? cost;
  final double? purchaseCost;
  final String? defaultPricingType;
  final double? defaultPrice;
  final List<Store?>? stores;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
}

@JsonSerializable()
class Store {
  Store({
    this.storeId,
    this.pricingType,
    this.price,
    this.availableForSale,
    this.optimalStock,
    this.lowStock,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);

  final String? storeId;
  final String? pricingType;
  final double? price;
  final bool? availableForSale;
  final String? optimalStock;
  final String? lowStock;
}
