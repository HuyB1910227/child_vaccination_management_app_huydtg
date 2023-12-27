import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/disease/disease.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class DiseaseService extends ApiService {
  DiseaseService([AuthToken? authToken]) : super (authToken);

  Future<Disease?> fetchDiseaseById(id) async {
    try {
      final diseaseUrl = Uri.parse('$defaultUrl/api/diseases/$id');
      final response = await http.get(
        diseaseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        return null; 
      }
      final diseaseUrlString =
      utf8.decode(response.bodyBytes);
      final diseaseUrlMap =
      json.decode(diseaseUrlString);

      if (diseaseUrlMap.isEmpty) {
        return null;
      }
      final disease = Disease.fromJson(diseaseUrlMap);
      return disease;
    } catch (error) {
      return null;
    }
  }

  Future<Disease?> fetchDiseaseWithVaccineRelationshipById(id) async {
    try {
      final diseaseUrl = Uri.parse('$defaultUrl/api/diseases/$id/with-vaccines');
      final response = await http.get(
        diseaseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        return null;
      }
      final diseaseUrlString =
      utf8.decode(response.bodyBytes);
      final diseaseUrlMap =
      json.decode(diseaseUrlString);
      print(diseaseUrlMap);
      if (diseaseUrlMap.isEmpty) {
        return null;
      }
      try {
        final disease = Disease.fromJson(diseaseUrlMap);
        print(disease.id);
        return disease;
      } catch(e) {
        print(e);
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}