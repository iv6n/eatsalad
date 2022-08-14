import 'dart:io';

import 'package:loyverse_api/loyverse_api.dart';

void main() async {
  final loyverseApiClient = LoyverseApiClient();

  try {
    final its = await loyverseApiClient.items('');
    final cats = await loyverseApiClient.categories('');

    for (final Category? category in cats.categories) {
      print('--------${category!.name}---------');
      for (final Item? item in its.items) {
        if (item!.categoryId == category.id) {
          //print(item.itemName);
          for (final Variant? variant in item.variants ?? [])
            print('${item.itemName} Price:\$ ${variant!.defaultPrice}');
        }
        print(item.description);
      }
    }
  } on Exception catch (e) {
    print(e);
  }

  exit(0);
}
