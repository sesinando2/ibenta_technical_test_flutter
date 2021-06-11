import 'dart:convert';

import 'package:http/http.dart';
import 'package:ibenta_technical_test_flutter/data/api_constants.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path) async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.BASE_URL}$path'),
      headers: {'Content-Type': 'application-json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(String path, Object? body) async {
    print(body);
    final response = await _client.post(
      Uri.parse('${ApiConstants.BASE_URL}$path'),
      headers: {'Content-Type': 'application/json;charset=UTF-8'},
      body: json.encode(body),
    );

    print(response.statusCode);
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic delete(String path) async {
    final response = await _client.delete(
      Uri.parse('${ApiConstants.BASE_URL}$path'),
    );

    print(response.statusCode);

    if (response.statusCode == 204) {
      return {};
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic put(String path, Object? body) async {
    print(body);

    final response = await _client.put(
      Uri.parse('${ApiConstants.BASE_URL}$path'),
      headers: {'Content-Type': 'application/json;charset=UTF-8'},
      body: json.encode(body),
    );

    print(response.request);
    print(response.statusCode);
    print(body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }
}
