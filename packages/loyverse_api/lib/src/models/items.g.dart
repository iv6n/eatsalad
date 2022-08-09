// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
    items: (json['items'] as List)
        .map((dynamic e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] as String,
    handle: json['handle'] as String?,
    itemName: json['item_name'] as String?,
    description: json['description'] as String?,
    referenceId: json['reference_id'] as String?,
    categoryId: json['category_id'] as String,
    trackStock: json['track_stock'] as bool?,
    soldByWeight: json['sold_by_weight'] as bool?,
    isComposite: json['is_composite'] as bool?,
    useProduction: json['use_production'] as bool?,
    components: (json['components'] as List)
        .map((dynamic e) =>
            e == null ? null : Component.fromJson(e as Map<String, dynamic>))
        .toList(),
    primarySupplierId: json['primary_supplier_id'] as String?,
    taxIds: (json['tax_ids'] as List).map((dynamic e) => e as String).toList(),
    modifiersIds: (json['modifiers_ids'] as List?)
            ?.map((dynamic e) => e as String)
            .toList() ??
        [],
    form: json['form'] as String,
    color: json['color'] as String,
    imageUrl: json['image_url'] as String?,
    option1Name: json['option1_name'] as String?,
    option2Name: json['option2_name'] as String?,
    option3Name: json['option3_name'] as String?,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String?,
    deletedAt: json['deleted_at'] as String?,
    variants: (json['variants'] as List?)
            ?.map((dynamic e) =>
                e == null ? null : Variant.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'handle': instance.handle,
      'itemName': instance.itemName,
      'description': instance.description,
      'referenceId': instance.referenceId,
      'categoryId': instance.categoryId,
      'trackStock': instance.trackStock,
      'soldByWeight': instance.soldByWeight,
      'isComposite': instance.isComposite,
      'useProduction': instance.useProduction,
      'components': instance.components,
      'primarySupplierId': instance.primarySupplierId,
      'taxIds': instance.taxIds,
      'modifiersIds': instance.modifiersIds,
      'form': instance.form,
      'color': instance.color,
      'imageUrl': instance.imageUrl,
      'option1Name': instance.option1Name,
      'option2Name': instance.option2Name,
      'option3Name': instance.option3Name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'deletedAt': instance.deletedAt,
      'variants': instance.variants,
    };

Component _$ComponentFromJson(Map<String, dynamic> json) {
  return Component(
    variantId: json['variant_id'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
      'variantId': instance.variantId,
      'quantity': instance.quantity,
    };

Variant _$VariantFromJson(Map<String, dynamic> json) {
  return Variant(
    variantId: json['variant_id'] as String,
    itemId: json['item_id'] as String,
    sku: json['sku'] as String,
    referenceVariantId: json['reference_variant_id'] as String?,
    option1Value: json['option1_value'] as String?,
    option2Value: json['option2_value'] as String?,
    option3Value: json['option3_value'] as String?,
    barcode: json['barcode'] as String?,
    cost: json['cost'] as double?,
    purchaseCost: json['purchase_cost'] as double?,
    defaultPricingType: json['default_pricing_type'] as String?,
    defaultPrice: json['default_price'] as double?,
    stores: (json['stores'] as List?)
            ?.map((dynamic e) =>
                e == null ? null : Store.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String?,
    deletedAt: json['deleted_at'] as String?,
  );
}

Map<String, dynamic> _$VariantToJson(Variant instance) => <String, dynamic>{
      'variant_id': instance.variantId,
      'item_id': instance.itemId,
      'sku': instance.sku,
      'reference_variant_id': instance.referenceVariantId,
      'option1_value': instance.option1Value,
      'option2_value': instance.option2Value,
      'option3_value': instance.option3Value,
      'barcode': instance.barcode,
      'cost': instance.cost,
      'purchase_cost': instance.purchaseCost,
      'default_pricing_type': instance.defaultPricingType,
      'default_pricing': instance.defaultPrice,
      'stores': instance.stores,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    storeId: json['store_id'] as String,
    pricingType: json['pricing_type'] as String?,
    price: json['price'] as double?,
    availableForSale: json['available_for_sale'] as bool?,
    optimalStock: json['optimal_stock'] as String?,
    lowStock: json['low_stock'] as String?,
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'store_id': instance.storeId,
      'pricing_type': instance.pricingType,
      'price': instance.price,
      'available_for_sale': instance.availableForSale,
      'optimal_stock': instance.optimalStock,
      'low_stock': instance.lowStock,
    };
