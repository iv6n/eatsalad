import 'package:bloc/bloc.dart';
import 'package:eatsalad/home/tabs/catalog/catalog.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit(
    this.menuRepository,
  ) : super(const MenuState.loading());

  final MenuRepository menuRepository;

  Future<void> getMenu() async {
    if (!menuRepository.isConfigured) {
      // Sin LOYVERSE_API_KEY no hay nada real que pedirle a Loyverse — se
      // muestra el catálogo de muestra para poder probar/hacer demo de la
      // app completa (menú, búsqueda, carrito, checkout).
      emit(MenuState.success(categories: mockCategories, items: mockItems));
      return;
    }

    try {
      final results2 = await menuRepository.fetchCategories();
      final categories = results2
          .map(
            (result) => Category(
              result.id.toString(),
              result.name.toString(),
              result.color.toString(),
            ),
          )
          .toList();
      final results1 = await menuRepository.fetchItems();
      final items = results1.map((result) {
        final variants = result.variants ?? const [];
        final firstVariant = variants.isEmpty ? null : variants.first;
        return Item(
          id: result.id.toString(),
          itemName: result.itemName.toString(),
          description: result.description.toString(),
          categoryId: result.categoryId.toString(),
          imageUrl: result.imageUrl.toString(),
          variants: firstVariant == null
              ? null
              : Variant(
                  firstVariant.variantId.toString(),
                  firstVariant.itemId.toString(),
                  firstVariant.sku.toString(),
                  (firstVariant.defaultPrice ?? 0).toDouble(),
                ),
        );
      }).toList();
      emit(MenuState.success(categories: categories, items: items));
    } on Exception {
      emit(const MenuState.failure());
    }
  }
}
