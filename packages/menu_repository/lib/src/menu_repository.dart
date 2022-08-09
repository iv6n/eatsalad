import 'package:loyverse_api/loyverse_api.dart';

/// Thrown when an error occurs while performing a search.
class SearchException implements Exception {}

/// Thrown when an error occurs while looking up synonyms.
class SynonymsException implements Exception {}

/// {@template Menu_repository}
/// A Dart class which exposes methods to implement Menu functionality.
/// {@endtemplate}
class MenuRepository {
  /// {@macro Menu_repository}

  final loyverseApiClient = LoyverseApiClient();

  /// Throws a [SearchException] if an error occurs.
  Future<List<Category>> fetchCategories({String? term}) async {
    try {
      final menu = await loyverseApiClient.categories('');
      return menu.categories;
    } on Exception {
      throw SearchException();
    }
  }

  /// Throws a [SearchException] if an error occurs
  Future<List<Item>> fetchItems({String? term}) async {
    try {
      final menu = await loyverseApiClient.items('');
      return menu.items;
    } on Exception {
      throw SearchException();
    }
  }

  // Future<List<Variant>> fetchVariants({String term}) async {
  //   try {
  //     final variants = await _loyverseApiClient.variants('');
  //     return variants;
  //   } on Exception {
  //     throw SearchException();
  //   }
  // }
}
