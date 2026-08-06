import 'dart:convert';

import 'package:loyverse_api/loyverse_api.dart';
import 'package:http/http.dart' as http;

/// Thrown if an exception occurs while making an `http` request.
class HttpException implements Exception {}

/// {@template http_request_failure}
/// Thrown if an `http` request returns a non-200 status code.
/// {@endtemplate}
class HttpRequestFailure implements Exception {
  /// {@macro http_request_failure}
  const HttpRequestFailure(this.statusCode);

  /// The status code of the response.
  final int statusCode;
}

/// Thrown if an excepton occurs while decoding the response body.
class JsonDecodeException implements Exception {}

/// Thrown is an error occurs while deserializing the response body.
class JsonDeserializationException implements Exception {}

/// {@template loyverse_api_client}
/// A Dart API Client for the loyverse REST API.
/// Learn more at https://api.loyverse.com
/// {@endtemplate}
///
class LoyverseApiClient {
  /// {@macro loyverse_api_client}
  ///
  /// [apiKey] must be supplied by the caller (e.g. via
  /// `--dart-define=LOYVERSE_API_KEY=...`) — it must never be hardcoded
  /// here, since this source is committed to version control.
  LoyverseApiClient({
    required this.apiKey,
    http.Client? httpClient,
    this.baseUrl = "api.loyverse.com",
  }) : this.httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;
  final String apiKey;
  static const _contextRoot = '/v1.0';

  /// Returns a list of Categories
  /// from a given vocabulary that match a given set of constraints.
  Future<Categories> categories(String categoryId) async {
    final uri = Uri.https(baseUrl, '$_contextRoot/categories/$categoryId');

    return _fetchCategories(uri);
  }

  Future<Categories> _fetchCategories(Uri uri) async {
    http.Response response;

    try {
      response = await httpClient.get(uri, headers: _header);
    } on Exception {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }
    Map body;
    try {
      body = json.decode(response.body) as Map;
    } on Exception {
      throw JsonDecodeException();
    }

    try {
      return Categories.fromJson(body as Map<String, dynamic>);
    } on Exception {
      throw JsonDeserializationException();
    }
  }

  Future<Items> items(String itemsId) async {
    final uri = Uri.https(baseUrl, '$_contextRoot/items/$itemsId');
    return _fetchItems(uri);
  }

  Future<Items> _fetchItems(Uri uri) async {
    http.Response response;

    try {
      response = await httpClient.get(uri, headers: _header);
    } on Exception {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }
    Map body;
    try {
      body = json.decode(response.body) as Map;
    } on Exception {
      throw JsonDecodeException();
    }

    try {
      return Items.fromJson(body as Map<String, dynamic>);
    } on Exception {
      throw JsonDeserializationException();
    }
  }

  Map<String, String> get _header => {'Authorization': 'Bearer $apiKey'};
}
