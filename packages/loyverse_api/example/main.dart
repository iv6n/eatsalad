// ignore_for_file: avoid_print
import 'dart:io';

import 'package:loyverse_api/loyverse_api.dart';

void main() async {
  // Supply your Loyverse API key at run time, e.g.:
  //   dart run example/main.dart --define=LOYVERSE_API_KEY=your_key
  const apiKey = String.fromEnvironment('LOYVERSE_API_KEY');
  final loyverseApiClient = LoyverseApiClient(apiKey: apiKey);

  try {
    final its = await loyverseApiClient.items('');
    final cats = await loyverseApiClient.categories('');

    for (final Category? category in cats.categories) {
      print('--------${category!.name}---------');
      for (final Item? item in its.items) {
        if (item!.categoryId == category.id) {
          for (final Variant? variant in item.variants ?? []) {
            print('${item.itemName} Price:\$ ${variant!.defaultPrice}');
          }
        }
        print(item.description);
      }
    }
  } on Exception catch (e) {
    print(e);
  }

  exit(0);
}
