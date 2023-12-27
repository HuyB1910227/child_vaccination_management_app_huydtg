import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/nutrition/nutrition.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class NutritionService extends ApiService {
  NutritionService([AuthToken? authToken]) : super (authToken);

  Future<List<Nutrition>> fetchNutritionByPatientId(String patientId) async {
    print("Tìm kiếm chỉ số");
    final List<Nutrition> nutritions = [];
    try {
      print(accessToken);
      final url = Uri.parse('$defaultUrl/api/nutritions/all?patientId.equals=$patientId');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        print("Not found schedule");
        return [];
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      final resultMap =
      json.decode(resultString);
      if (resultMap.isEmpty) {
        return [];
      }
      try{
        resultMap.forEach((d) {
          nutritions.add(Nutrition.fromJson(d));
        });
        print(nutritions);
        return nutritions;
      } catch(e) {
        print(e);
      }
      print("founded fixed nutrition");
      print(nutritions);
      return nutritions;
    } catch (error) {
      return [];
    }
  }
}