import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/age/age.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class AgeService extends ApiService {
  AgeService([AuthToken? authToken]) : super (authToken);

  Future<List<Age>> fetchAgeByVaccineId(id) async {
    print("Tìm kiếm giai đoạn");
    final List<Age> ages = [];
    try {
      print(accessToken);
      final url = Uri.parse('$defaultUrl/api/ages?vaccineId.equals=$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        print("Not found disease");
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
          ages.add(Age.fromJson(d));
        });
        print(ages);
        return ages;
      } catch(e) {
        print(e);
      }
      return ages;
    } catch (error) {
      return [];
    }
  }
}

