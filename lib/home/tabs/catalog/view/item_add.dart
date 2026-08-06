import 'package:eatsalad/home/tabs/cart/bloc/cart_bloc.dart';
import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemAdd extends StatefulWidget {
  const ItemAdd({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  State<ItemAdd> createState() => _ItemAddState();
}

class _ItemAddState extends State<ItemAdd> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final price = item.variants?.price ?? 0;
    final imageUrl = item.imageUrl;
    final hasImage =
        imageUrl != null && imageUrl.isNotEmpty && imageUrl != 'null';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(item.itemName ?? 'Add Item'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 30,
                child: Row(
                  children: [
                    FloatingActionButton(
                      elevation: 4.0,
                      heroTag: 'itemAdd_decrement',
                      onPressed: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                      child: const Icon(Icons.remove),
                    ),
                    SizedBox(
                      width: 32,
                      child: Text(
                        '$_quantity',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FloatingActionButton(
                      elevation: 4.0,
                      heroTag: 'itemAdd_increment',
                      onPressed: () => setState(() => _quantity++),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              FloatingActionButton.extended(
                elevation: 4.0,
                label: Text(
                  'Add to order  \$${(price * _quantity).toStringAsFixed(2)}',
                ),
                onPressed: () {
                  final cartBloc = context.read<CartBloc>();
                  for (var i = 0; i < _quantity; i++) {
                    cartBloc.add(CartItemAdded(item));
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 260,
              child: hasImage
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const _ImagePlaceholder(),
                    )
                  : const _ImagePlaceholder(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemName ?? 'Item',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const DividerBoy(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                (item.description == null ||
                        item.description!.isEmpty ||
                        item.description == 'null')
                    ? 'Sin descripción disponible.'
                    : item.description!,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.fastfood, size: 48, color: Colors.black26),
    );
  }
}

class DividerBoy extends StatelessWidget {
  const DividerBoy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 45,
      color: Colors.black,
    );
  }
}
