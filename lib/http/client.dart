import 'dart:convert';

import 'package:http/http.dart' as net;

/**
 * Singleton para el cliente HTTP
 */
class HttpClient {
  final String _base_path = "https://room-me-app.herokuapp.com/api";
  final String _login = "https://room-me-app.herokuapp.com/api/login";
  Map<String, String> headers = Map();
  Map<String, String> cookies = Map();

  static HttpClient _client = null;

  HttpClient() {
    headers["Content-type"] = "application/json";
  }

  static HttpClient getClient() {
    if (HttpClient._client == null) {
      HttpClient._client = HttpClient();
    }
    return HttpClient._client;
  }

  Future<Map<String, dynamic>> get(
      final String url, final Map<String, dynamic> params) async {
    print(headers);
    final net.Response response = await net.get(
      url,
      headers: headers,
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(
      final String url, final Map<String, dynamic> body) async {
    final net.Response response = await net.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> put(
      final String url, final Map<String, dynamic> body) async {
    final net.Response response = await net.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> delete(
      final String url, final Map<String, dynamic> params) async {
    final net.Response response = await net.delete(
      url,
      headers: headers,
    );
    return jsonDecode(response.body);
  }

  Future<bool> login(String email, String password) async {
    try {
      var body = jsonEncode({'email': email, 'password': password});
      net.Response response =
          await net.post(_login, headers: headers, body: body);
      if (response.statusCode == 401) {
        return false;
      }
      print(response.headers);
      _updateCookie(response);
      return true;
    } catch (e) {
      return false;
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0) cookie += ";";
      cookie += key + "=" + cookies[key];
    }

    return cookie;
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];
        if (key == 'path' || key == 'expires') return;
        this.cookies[key] = value;
      }
    }
  }

  void _updateCookie(net.Response response) {
    String allSetCookie = response.headers['set-cookie'];
    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');
      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');
        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }
      headers['cookie'] = _generateCookieHeader();
    }
  }
}
