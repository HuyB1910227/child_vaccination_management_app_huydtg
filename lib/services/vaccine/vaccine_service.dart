import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/vaccine/vaccine.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class VaccineService extends ApiService {
  VaccineService([AuthToken? authToken]) : super (authToken);

  Future<Vaccine?> fetchVaccineById(id) async {
    try {
      final url = Uri.parse('$defaultUrl/api/vaccines/$id');
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
      final resultString =
      utf8.decode(response.bodyBytes);
      print(resultString);
      final resultMap =
      json.decode(resultString);
      print(resultMap);
      if (resultMap.isEmpty) {
        return null;
      }
      try{
        final vaccine = Vaccine.fromJson(resultMap);
        print(vaccine);
        print(vaccine.description.length);
        return vaccine;
      } catch(e) {
        print(e);
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}