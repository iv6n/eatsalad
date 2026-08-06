import 'package:loyverse_api/loyverse_api.dart';

/// Thrown when an error occurs while performing a search.
class SearchException implements Exception {}

/// {@template Menu_repository}
/// A Dart class which exposes methods to implement Menu functionality.
/// {@endtemplate}
class MenuRepository {
  /// {@macro Menu_repository}
  ///
  /// [apiKey] is the Loyverse API key, supplied by the caller — see
  /// [LoyverseApiClient].
  MenuRepository({required String apiKey})
      : loyverseApiClient = LoyverseApiClient(apiKey: apiKey);

  final LoyverseApiClient loyverseApiClient;

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
}
