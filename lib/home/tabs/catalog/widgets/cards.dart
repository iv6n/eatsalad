import 'package:eatsalad/home/tabs/cart/bloc/cart_bloc.dart';
import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:eatsalad/home/tabs/catalog/view/item_add.dart';
import 'package:eatsalad/home/tabs/catalog/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Renders [item]'s image, falling back to a placeholder icon when there's
/// no image URL or the network image fails to load (Loyverse items aren't
/// guaranteed to have an image).
Widget _itemImage(
  Item item, {
  required double width,
  required double height,
  BoxFit fit = BoxFit.cover,
}) {
  final url = item.imageUrl;
  if (url == null || url.isEmpty || url == 'null') {
    return _imagePlaceholder(width: width, height: height);
  }
  return Image.network(
    url,
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (context, error, stackTrace) =>
        _imagePlaceholder(width: width, height: height),
  );
}

Widget _imagePlaceholder({required double width, required double height}) {
  return Container(
    width: width,
    height: height,
    color: Colors.grey[200],
    child: const Icon(Icons.fastfood, color: Colors.black26),
  );
}

/// Formats [item]'s price, falling back to a dash when the item has no
/// variant/price yet (Loyverse items aren't guaranteed to have one).
String _priceLabel(Item item) {
  final price = item.variants?.price;
  return price != null ? '\$${price.toStringAsFixed(2)}' : '—';
}

void _openItem(BuildContext context, Item item) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ItemAdd(item: item)),
  );
}

void _quickAddToCart(BuildContext context, Item item) {
  context.read<CartBloc>().add(CartItemAdded(item));
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text('${item.itemName ?? 'Item'} agregado al carrito')),
    );
}

/// A wide card for combo-style menu items, showing the item's real image,
/// name and price.
class ComboCard extends StatelessWidget {
  const ComboCard({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.5, vertical: 3),
      child: SizedBox(
        width: size.width * 0.55,
        child: Card(
          elevation: 2.5,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () => _openItem(context, item),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _itemImage(item, width: double.infinity, height: 110),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.itemName ?? 'Combo',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _priceLabel(item),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.0,
      child: Card(
        elevation: 2.5,
        margin: const EdgeInsets.all(6),
        color: Colors.grey[50],
        child: InkWell(
          onTap: () => _openItem(context, item),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 5, top: 8, right: 10, bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 2,
                    child: _itemImage(item, width: double.infinity, height: 69),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(item.itemName ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              child: Text(
                                item.description ?? '',
                                style: const TextStyle(fontSize: 10),
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              _priceLabel(item),
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            AddButton(onPressed: () => _quickAddToCart(context, item)),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SaladCard extends StatelessWidget {
  const SaladCard({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 3),
      child: SizedBox(
        width: 135,
        height: 180,
        child: Card(
          elevation: 2.5,
          color: Colors.grey[50],
          child: InkWell(
            onTap: () => _openItem(context, item),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 3),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: _itemImage(item, width: 78, height: 78, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.itemName ?? '',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 100,
                    child: Text(
                      'Arma tu ensalada para 1-2 personas',
                      style:
                          TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _priceLabel(item),
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        AddButton(onPressed: () => _quickAddToCart(context, item)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
