import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/auth_token.dart';

class AuthService {
  static const _authTokenKey = 'accessToken';
  late final String? _defaultUrl;
  AuthService() {
    _defaultUrl = dotenv.env["DEFAULT_URL"];
  }

  String _buildAuthUrl() {
    return '$_defaultUrl/api/auth/user/login';
  }

  String _buildLogoutUrl () {
    return '$_defaultUrl/api/auth/signout';
  }

  Future<AuthToken> _authenticate(String username, String password) async {
    try {
      final url = Uri.parse(_buildAuthUrl());
      print(url);
      final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
        {
          'username': username,
          'password': password
        },
      ),
      );

      final responseJson = json.decode(response.body);
      print(responseJson);
      final authToken = _fromJson(responseJson);
      log(authToken.id);
      _saveAuthToken(authToken);

      return authToken;
    } catch(error) {
      rethrow;
    }

  }

  Future<void> logoutRequest() async {
    final authToken = await loadSavedAuthToken();
    final accessToken = authToken?.accessToken;
    print("Prepare logout");
    print(accessToken);
    try {
      final url = Uri.parse(_buildLogoutUrl());
      final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(response.headers);
      print("Logout successful!!");

    } catch (error) {
      rethrow;
    }

  }

  Future<AuthToken> login(String username, String password) {
    print("Đăng nhập");
    print(username);
    print(password);
    return _authenticate(username, password);
  }

  Future<void> _saveAuthToken(AuthToken authToken) async {
    print("Chuẩn bị lưu cái prefs");
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_authTokenKey, json.encode(authToken.toJson()));
    print("Lưu rồi");
    print(prefs.getString(_authTokenKey));
  }

  AuthToken _fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      tokenType: json['tokenType'],
      id: json['id'],
      username: json['username'],
      phone: json['phone'],
    );
  }

  Future<AuthToken?> loadSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_authTokenKey)) {
      log("Not found auth token key");
      return null;
    }
    final savedToken = prefs.getString(_authTokenKey);
    log('savedToken: $savedToken');
    print("Saved auth token");
    print(savedToken);
    final authToken = AuthToken.fromJson(json.decode(savedToken!));
    if (!authToken.isValid) {
      log("auth token have null ____ accessToken");
      return null;
    }
    print("auth token");
    print(authToken);
    return authToken;
  }

  Future<void> clearSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_authTokenKey);
  }

}