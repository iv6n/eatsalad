import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:equatable/equatable.dart';

enum FulfillmentType { pickup, delivery }

class Order extends Equatable {
  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.fulfillmentType,
    required this.customerName,
    required this.customerPhone,
    required this.createdAt,
    this.address,
    this.notes,
  });

  final String id;
  final List<Item> items;
  final double total;
  final FulfillmentType fulfillmentType;
  final String customerName;
  final String customerPhone;
  final DateTime createdAt;
  final String? address;
  final String? notes;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      items: (json['items'] as List)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      fulfillmentType: FulfillmentType.values.byName(
        json['fulfillmentType'] as String,
      ),
      customerName: json['customerName'] as String,
      customerPhone: json['customerPhone'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      address: json['address'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items.map((item) => item.toJson()).toList(),
        'total': total,
        'fulfillmentType': fulfillmentType.name,
        'customerName': customerName,
        'customerPhone': customerPhone,
        'createdAt': createdAt.toIso8601String(),
        'address': address,
        'notes': notes,
      };

  @override
  List<Object?> get props => [
        id,
        items,
        total,
        fulfillmentType,
        customerName,
        customerPhone,
        createdAt,
        address,
        notes,
      ];
}
