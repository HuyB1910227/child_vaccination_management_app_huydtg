import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../models/auth_token.dart';
import '../api_service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
class AvatarService extends ApiService {
  AvatarService([AuthToken? authToken]) : super (authToken);

  Future<Uint8List> loadImage(String imageUrl) async {
    final httpClient = HttpClient();
    Uint8List imageData = Uint8List(0);
    try {
      final request = await httpClient.getUrl(Uri.parse(imageUrl));
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer ${accessToken ?? ""}");
      final response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        imageData = bytes;
      }
    } catch (e) {
      print("Error loading image: $e");
    } finally {
      httpClient.close();
    }

    return imageData;
  }

  Future<String?> updatePatientAvatar(File imageFile, String patientId) async {
    try {
      final url = Uri.parse('$defaultUrl/api/avatar/patient/${patientId}');
      print(url);
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $accessToken';
      final mimeType = lookupMimeType(imageFile.path);
      final multipartFile = http.MultipartFile(
        'image',
        File(imageFile.path).readAsBytes().asStream(),
        File(imageFile.path).lengthSync(),
        filename: patientId,
        contentType: MediaType.parse(mimeType!),
      );
      request.files.add(multipartFile);
      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode != 200) {
        print(utf8.decode(response.bodyBytes));
        return null;
      }
      final responseDataString = utf8.decode(response.bodyBytes);
      print(responseDataString);
      return responseDataString;
    } catch (error) {
      return null;
    }
  }


  Future<String?> updateUserAvatar(File imageFile) async {
    try {
      final url = Uri.parse('$defaultUrl/api/avatar/user');
      print(url);
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $accessToken';
      String last10Characters = accessToken!.substring(accessToken!.length - 10);
      final mimeType = lookupMimeType(imageFile.path);
      final multipartFile = http.MultipartFile(
        'image',
        File(imageFile.path).readAsBytes().asStream(),
        File(imageFile.path).lengthSync(),
        filename: last10Characters,
        contentType: MediaType.parse(mimeType!),
      );
      request.files.add(multipartFile);
      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode != 200) {
        print(utf8.decode(response.bodyBytes));
        return null;
      }
      final responseDataString = utf8.decode(response.bodyBytes);
      print(responseDataString);
      return responseDataString;
    } catch (error) {
      return null;
    }
  }
}