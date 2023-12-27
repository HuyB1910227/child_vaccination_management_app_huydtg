import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/vaccine_lot/vaccine_available.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class VaccineLotService extends ApiService {
  VaccineLotService([AuthToken? authToken]) : super (authToken);

  Future<List<VaccineAvailable>> fetchVaccineAvailableByImmunizationUnitId(String id) async {
    List<VaccineAvailable> vaccinesAvailable = [];
    try {
      final url = Uri.parse('$defaultUrl/api/vaccine-lots/vaccine-available/by-immunization-unit/$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        return [];
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      print(resultString);
      final resultMap =
      json.decode(resultString);
      print(resultMap);
      if (resultMap.isEmpty) {
        return [];
      }
      resultMap.forEach((data) {
        vaccinesAvailable.add(VaccineAvailable.fromJson(data));
      });
      return vaccinesAvailable;
    } catch (error) {
      return [];
    }
  }
}