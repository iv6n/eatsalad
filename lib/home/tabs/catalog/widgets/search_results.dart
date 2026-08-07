import 'package:eatsalad/home/tabs/cart/bloc/cart_bloc.dart';
import 'package:eatsalad/home/tabs/catalog/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.onTap,
  });

  final ValueSetter<Item> onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SearchStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('oops try again!')),
            );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.success:
            return ListView.builder(
                key: const PageStorageKey("SearchResults-menu"),
                shrinkWrap: true,
                itemCount: state.suggestions.length,
                itemBuilder: (context, index) => _SearchResult(
                      item: state.suggestions[index],
                      onTap: () => onTap(state.suggestions[index]),
                    ));

          case SearchStatus.failure:
            return const Text('Error');
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({
    required this.onTap,
    required this.item,
  });

  final Item item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            leading: (item.imageUrl != null &&
                    item.imageUrl != 'null' &&
                    item.imageUrl!.isNotEmpty)
                ? ImageIcon(NetworkImage(item.imageUrl!))
                : const Icon(Icons.fastfood),
            title: Text(item.itemName ?? ''),
            subtitle: Text('\$${item.variants?.price.toStringAsFixed(2) ?? '-'}'),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () =>
                  context.read<CartBloc>().add(CartItemAdded(item)),
            ),
          ),
        ),
      ),
    );
  }
}
