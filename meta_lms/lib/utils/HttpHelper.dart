import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String baseUrl;
  http.Client client;

  HttpHelper({
    this.baseUrl = 'https://de5b-101-184-29-123.ngrok-free.app',
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<dynamic> get(String url, {String? token}) async {
    try {
      debugPrint("GET: $baseUrl$url");
      final response = await client.get(
        Uri.parse('$baseUrl$url'),
        headers: _headers(token),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  String getBaseUrl() {
    return baseUrl;
  }

  Future<dynamic> post(String url, dynamic body, {String? token}) async {
    try {
      debugPrint("POST: $baseUrl$url");
      final response = await client.post(
        Uri.parse('$baseUrl$url'),
        headers: _headers(token),
        body: json.encode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<dynamic> put(String url, dynamic body, {String? token}) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl$url'),
        headers: _headers(token),
        body: json.encode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<dynamic> delete(String url, {String? token}) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl$url'),
        headers: _headers(token),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  // Utility method to generate headers
  Map<String, String> _headers(String? token) {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      default:
        throw Exception('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
