import 'package:bloc/bloc.dart';
import 'package:eatsalad/home/tabs/cart/models/cart.dart';
import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>(_onStarted);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
  }

  void _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      emit(const CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
          cart: Cart(
              items: List.from(state.cart.items.toList())..add(event.item)),
        ));
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
                items: List.from(state.cart.items.toList())
                  ..removeAt(event.index)),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }
}
