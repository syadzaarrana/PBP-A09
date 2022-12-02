import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class CookieRequest {
  Map<String, String> headers = {};
  Map<String, String> cookies = {};
  final http.Client _client = http.Client();
  String? username = "";
  String email = "";
  bool is_admin = false;
  bool is_regular = false;
  bool is_bank = false;
  int id = 0;

  String message = "";

  // late SharedPreferences local;
  late SharedPreferences local;

  bool loggedIn = false;
  bool signedUp = false;
  bool initialized = false;

  Future init(BuildContext context) async {
    if (!initialized) {
      local = await SharedPreferences.getInstance();
      String? savedCookies = local.getString("cookies");
      if (savedCookies != null) {
        cookies = Map<String, String>.from(json.decode(savedCookies));
        if (cookies['sessionid'] != null) {
          loggedIn = true;
          headers['cookie'] = _generateCookieHeader();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully logged in. Welcome back!"),
          ));
        }
      }
    }
    initialized = true;
  }

  Future persist(String cookies) async {
    local.setString("cookies", cookies);
  }

  Future<dynamic> login(String url, dynamic data) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }

    http.Response response =
    await _client.post(Uri.parse(url), body: data, headers: headers);

    _updateCookie(response);

    if (response.statusCode == 200) {

      username = (json.decode(response.body)['data']['user']['username'] == Null ?
        "" : json.decode(response.body)['data']['user']['username']);
      email = json.decode(response.body)['data']['user']['email'];
      is_admin = json.decode(response.body)['data']['user']['is_admin'];
      is_regular = json.decode(response.body)['data']['user']['is_regular'];
      is_bank = json.decode(response.body)['data']['user']['is_bank'];
      id = json.decode(response.body)['data']['user']['id'];
      loggedIn = true;
    } else {
      loggedIn = false;
    }

    return json.decode(response.body); // Expects and returns JSON request body
  }

  Future<dynamic> signup(String url, dynamic data) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }

    http.Response response =
    await _client.post(Uri.parse(url), body: data, headers: headers);

    _updateCookie(response);

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      signedUp = true;
    } else {
      print(json.decode(response.body));
      message = json.decode(response.body)['data']['warning'];
      signedUp = false;
    }

    return json.decode(response.body); // Expects and returns JSON request body
  }


  Future<dynamic> get(String url) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }
    http.Response response =
    await _client.get(Uri.parse(url), headers: headers);
    _updateCookie(response);
    return json.decode(response.body); // Expects and returns JSON request body
  }

  Future<dynamic> post(String url, dynamic data) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }
    http.Response response =
    await _client.post(Uri.parse(url), body: data, headers: headers);
    _updateCookie(response);
    return json.decode(response.body); // Expects and returns JSON request body
  }

  void _updateCookie(http.Response response) {
    String? allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
      String cookieObject = (const JsonEncoder()).convert(cookies);
      persist(cookieObject);
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.isNotEmpty) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;

        cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.isNotEmpty) cookie += ";";
      String? newCookie = cookies[key];
      cookie += '$key=$newCookie';
    }

    return cookie;
  }

  Future<dynamic> logoutAccount(String url) async {
    http.Response response = await _client.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'loggedIn': true,
        })
    );
    // print(json.decode(response.body));
    print(response.statusCode);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      loggedIn = false;
      username = "";
      email = "";
      is_admin = false;
      is_regular = false;
      is_bank = false;
      id = 0;

    } else {
      loggedIn = true;
    }

    cookies = {};

    return json.decode(response.body);
  }

}