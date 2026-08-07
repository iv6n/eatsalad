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
                const SnackBar(content: Text('No se pudo cargar el menú.')),
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
            case MenuStatus.failure:
              return const _MenuFailure();
          }
        },
      ),
    );
  }
}

class _MenuFailure extends StatelessWidget {
  const _MenuFailure();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 56, color: Colors.black26),
            const SizedBox(height: 12),
            const Text(
              'No se pudo cargar el menú',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              'Revisa tu conexión e intenta de nuevo.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<MenuCubit>().getMenu(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuSuccess extends StatelessWidget {
  const _MenuSuccess({
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
