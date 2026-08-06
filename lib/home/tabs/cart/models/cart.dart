import 'package:eatsalad/home/tabs/catalog/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Cart extends Equatable {
  const Cart({this.items = const <Item>[]});

  final List<Item> items;

  double get totalPrice => items.fold(
      0, (total, current) => total + (current.variants?.price ?? 0));

  @override
  List<Object?> get props => [items];
}
