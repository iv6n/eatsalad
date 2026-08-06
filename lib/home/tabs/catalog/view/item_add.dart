import 'package:eatsalad/home/tabs/cart/bloc/cart_bloc.dart';
import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemAdd extends StatelessWidget {
  const ItemAdd({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    final price = item.variants?.price ?? 0;
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
                        child: const Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      const Text('0'),
                      FloatingActionButton(
                        elevation: 4.0,
                        child: const Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                FloatingActionButton.extended(
                  elevation: 4.0,
                  label: Text('Add to order  \$${price.toStringAsFixed(2)}'),
                  onPressed: () {
                    context.read<CartBloc>().add(CartItemAdded(item));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(
                height: 560,
              ),
              DividerBoy(),
              SizedBox(
                height: 400,
              ),
              DividerBoy(),
              SizedBox(
                height: 200,
              ),
              DividerBoy(),
              SizedBox(
                height: 360,
              ),
              DividerBoy(),
              SizedBox(
                height: 360,
              ),
            ],
          ),
        ));
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
