import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:eatsalad/home/tabs/cart/models/cart.dart';
import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync(),
        super(CartLoading()) {
    on<CartStarted>(_onStarted);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
  }

  static const _cartCacheKey = 'cart';

  final SharedPreferencesAsync _preferences;

  void _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cached = await _preferences.getString(_cartCacheKey);
      final cart = cached == null
          ? const Cart()
          : Cart.fromJson(jsonDecode(cached) as Map<String, dynamic>);
      emit(CartLoaded(cart: cart));
    } catch (_) {
      emit(const CartLoaded());
    }
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        final cart = Cart(
          items: List.from(state.cart.items.toList())..add(event.item),
        );
        emit(CartLoaded(cart: cart));
        await _persist(cart);
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        final cart = Cart(
          items: List.from(state.cart.items.toList())
            ..removeAt(event.index),
        );
        emit(CartLoaded(cart: cart));
        await _persist(cart);
      } catch (_) {
        emit(CartError());
      }
    }
  }

  Future<void> _persist(Cart cart) {
    return _preferences.setString(_cartCacheKey, jsonEncode(cart.toJson()));
  }
}
