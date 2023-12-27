import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user/user.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class UserService extends ApiService {
  UserService([AuthToken? authToken]) : super (authToken);

  Future<User?> fetchCustomerByToken() async {
    try {
      final url = Uri.parse('$defaultUrl/api/users/token');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        print("Not found user");
        return null;
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      final resultMap =
      json.decode(resultString);
      if (resultMap.isEmpty) {
        return null;
      }
      try{
        final user = User.fromJson(resultMap);
        print("founded user");
        print(user);
        return user;
      } catch(e) {
        print(e);
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<bool> isInvalidValue(String? phone, String? username) async {
    final request = {
      "phone": phone,
      "username": username,
    };
    print(request);
    try {
      final url = Uri.parse('$defaultUrl/api/users/is-invalid-unique-value');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
        body: json.encode(request),
      );
      final responseDataString =
      utf8.decode(response.bodyBytes);
      print(responseDataString);
      final responseDataMap =
      json.decode(responseDataString);
      return responseDataMap;
    } catch (error) {
      return false;
    }
  }

  Future<User?> updateUsername(String username) async {
    final request = {
      "username": username,
    };
    // print(request);
    try {
      final url = Uri.parse('$defaultUrl/api/users/change-username/token');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
        body: json.encode(request),
      );
      if (response.statusCode != 200) {
        print("update username error");
        return null;
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      final resultMap =
      json.decode(resultString);
      if (resultMap.isEmpty) {
        print("resultmap is empty");
        return null;
      }
      print("resultmap :");
      print(resultMap);
      try{
        final user = User.fromJson(resultMap);
        print("founded user");
        print(user);
        return user;
      } catch(e) {
        print(e);
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<User?> updatePassword(String oldPassword, String newPassword) async {
    final request = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    try {
      final url = Uri.parse('$defaultUrl/api/users/change-password/token');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
        body: json.encode(request),
      );
      if (response.statusCode != 200) {
        print("update password error");
        return null;
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      final resultMap =
      json.decode(resultString);
      if (resultMap.isEmpty) {
        print("resultmap is empty");
        return null;
      }
      print("resultmap :");
      print(resultMap);
      try{
        final user = User.fromJson(resultMap);
        print("founded user");
        print(user);
        return user;
      } catch(e) {
        print(e);
      }
      return null;
    } catch (error) {
      return null;
    }
  }



}