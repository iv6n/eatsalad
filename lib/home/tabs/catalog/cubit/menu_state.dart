part of 'menu_cubit.dart';

enum MenuStatus { loading, success, failure }

class MenuState extends Equatable {
  const MenuState._({
    this.status = MenuStatus.loading,
    this.items = const <Item>[],
    this.categories = const <Category>[],
  });

  const MenuState.loading() : this._();

  const MenuState.success({
    required List<Category> categories,
    required List<Item> items,
  }) : this._(
          status: MenuStatus.success,
          categories: categories,
          items: items,
        );

  const MenuState.failure() : this._(status: MenuStatus.failure);

  final MenuStatus status;
  final List<Item> items;
  final List<Category> categories;

  @override
  List<Object?> get props => [status, items, categories];
}
