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
      final items = results1
          .map((result) => Item(
              id: result.id.toString(),
              itemName: result.itemName.toString(),
              description: result.description.toString(),
              categoryId: result.categoryId.toString(),
              imageUrl: result.imageUrl.toString(),
              variants: result.variants!
                  .map((e) => Variant(
                        e!.variantId.toString(),
                        e.itemId.toString(),
                        e.sku.toString(),
                        e.defaultPrice!.toDouble(),
                      ))
                  .first))
          .toList();
      emit(MenuState.success(categories: categories, items: items));
    } on Exception {
      emit(const MenuState.failure());
    }
  }
}
