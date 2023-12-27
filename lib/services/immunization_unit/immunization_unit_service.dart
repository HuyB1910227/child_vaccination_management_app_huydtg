import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/immunization_unit/immunization_unit.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class ImmunizationUnitService extends ApiService {
  ImmunizationUnitService([AuthToken? authToken]) : super (authToken);

  Future<ImmunizationUnit?> fetchImmunizationUnitById(String id) async {
    try {
      final url = Uri.parse('$defaultUrl/api/immunization-units/$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        return null;
      }
      final responseDataString =
      utf8.decode(response.bodyBytes);
      final responseDataMap =
      json.decode(responseDataString);
      if (responseDataMap.isEmpty) {
        return null;
      }
      final immunizationUnit = ImmunizationUnit.fromJson(responseDataMap);
      return immunizationUnit;
    } catch (error) {
      return null;
    }
  }


}