import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({
    required this.baseUrl,
    http.Client? httpClient,
    Map<String, String>? defaultHeaders,
  }) : _client = httpClient ?? http.Client(),
       _headers = {
         'Accept': 'application/json',
         'Content-Type': 'application/json',
         ...?defaultHeaders,
       };

  final String baseUrl;
  final http.Client _client;
  final Map<String, String> _headers;

  Uri _url(String path, [Map<String, dynamic>? query]) {
    final u = Uri.parse(baseUrl).resolve(path);
    return (query == null || query.isEmpty)
        ? u
        : u.replace(
            queryParameters: {
              ...u.queryParameters,
              ...query.map((k, v) => MapEntry(k, v.toString())),
            },
          );
  }

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final res = await _client.get(
      _url(path, query),
      headers: {..._headers, ...?headers},
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('GET $path failed (${res.statusCode}): ${res.body}');
    }
    final body = jsonDecode(res.body);
    if (body is Map<String, dynamic>) return body;
    throw Exception('Unexpected JSON (expected object).');
  }

  Future<Map<String, dynamic>> postJson(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final res = await _client.post(
      _url(path),
      headers: {..._headers, ...?headers},
      body: body != null ? jsonEncode(body) : null,
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('POST $path failed (${res.statusCode}): ${res.body}');
    }
    final responseBody = jsonDecode(res.body);
    if (responseBody is Map<String, dynamic>) return responseBody;
    throw Exception('Unexpected JSON (expected object).');
  }
}
