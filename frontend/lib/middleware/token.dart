import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<http.Response> authorizedGet(String url) async {
  final prefs = await SharedPreferences.getInstance();
  final jwt = prefs.getString('jwt');

  return http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      if (jwt != null) 'Authorization': 'Bearer $jwt',
    },
  );
}

Future<http.Response> authorizedPost(String url, Map<String, dynamic> body) async {
  final prefs = await SharedPreferences.getInstance();
  final jwt = prefs.getString('jwt');

  return http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      if (jwt != null) 'Authorization': 'Bearer $jwt',
    },
    body: jsonEncode(body),
  );
}
