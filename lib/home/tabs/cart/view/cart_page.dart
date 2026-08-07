import 'package:eatsalad/home/tabs/cart/bloc/cart_bloc.dart';
import 'package:eatsalad/home/tabs/cart/models/cart.dart';
import 'package:eatsalad/home/tabs/cart/view/checkout_page.dart';
import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static const String id = 'pag3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tu pedido')),
      body: const Column(
        children: [
          Expanded(child: CartList()),
          Divider(height: 1),
          CartTotal(),
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CartLoaded) {
          if (state.cart.items.isEmpty) {
            return const _EmptyCart();
          }
          final grouped = _groupItems(state.cart.items);
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: grouped.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final entry = grouped[index];
              return _CartLine(item: entry.key, indices: entry.value);
            },
          );
        }
        return const Center(child: Text('Algo salió mal, intenta de nuevo.'));
      },
    );
  }

  static List<MapEntry<Item, List<int>>> _groupItems(List<Item> items) {
    final grouped = <Item, List<int>>{};
    for (var i = 0; i < items.length; i++) {
      grouped.putIfAbsent(items[i], () => <int>[]).add(i);
    }
    return grouped.entries.toList();
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.black26),
            SizedBox(height: 12),
            Text(
              'Tu carrito está vacío',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              'Agrega productos desde el menú para armar tu pedido.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartLine extends StatelessWidget {
  const _CartLine({required this.item, required this.indices});

  final Item item;
  final List<int> indices;

  @override
  Widget build(BuildContext context) {
    final price = item.variants?.price ?? 0;
    final quantity = indices.length;
    final imageUrl = item.imageUrl;
    final hasImage =
        imageUrl != null && imageUrl.isNotEmpty && imageUrl != 'null';

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 56,
                height: 56,
                child: hasImage
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const _CartImagePlaceholder(),
                      )
                    : const _CartImagePlaceholder(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemName ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () =>
                  context.read<CartBloc>().add(CartItemRemoved(indices.first)),
            ),
            SizedBox(
              width: 24,
              child: Text('$quantity', textAlign: TextAlign.center),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () =>
                  context.read<CartBloc>().add(CartItemAdded(item)),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartImagePlaceholder extends StatelessWidget {
  const _CartImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.fastfood, color: Colors.black26),
    );
  }
}

class CartTotal extends StatelessWidget {
  const CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final cart = state is CartLoaded ? state.cart : const Cart();
            final isEmpty = cart.items.isEmpty;
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total', style: TextStyle(color: Colors.black54)),
                      Text(
                        '\$${cart.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: isEmpty
                      ? null
                      : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<CartBloc>(),
                                child: const CheckoutPage(),
                              ),
                            ),
                          ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: const Text('Continuar'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
