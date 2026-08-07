import 'dart:convert';

import 'package:eatsalad/home/tabs/cart/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  OrderRepository({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  static const _ordersCacheKey = 'orders';

  final SharedPreferencesAsync _preferences;

  Future<List<Order>> getOrders() async {
    final cached = await _preferences.getString(_ordersCacheKey);
    if (cached == null) return const [];

    final decoded = jsonDecode(cached) as List;
    final orders = decoded
        .map((e) => Order.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return orders;
  }

  Future<void> saveOrder(Order order) async {
    final orders = await getOrders();
    orders.insert(0, order);
    await _preferences.setString(
      _ordersCacheKey,
      jsonEncode(orders.map((o) => o.toJson()).toList()),
    );
  }
}
