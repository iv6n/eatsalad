import 'package:eatsalad/home/tabs/catalog/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'menu_body.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});
  static const String id = 'pag2';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<MenuCubit, MenuState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == MenuStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('oops try again!')),
              );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case MenuStatus.loading:
              //make shimmer menu or simillar
              return const Center(child: CircularProgressIndicator());
            case MenuStatus.success:
              //when menu is fetched:
              return _MenuSuccess(items: state.items);
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _MenuSuccess extends StatelessWidget {
  const _MenuSuccess({
    super.key,
    required this.items,
  });
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(items: items),
      child: const MenuBody(),
    );
  }
}
