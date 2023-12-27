import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/injection/injection.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class InjectionService extends ApiService {
  InjectionService([AuthToken? authToken]) : super (authToken);

  Future<List<Injection>> fetchInjectionByAgeIds(List<int> ids) async {
    print("Tìm kiếm giai đoạn");
    final List<Injection> injections = [];
    String ageIdsString = ids.join(",");
    print(ageIdsString);
    try {
      final url = Uri.parse('$defaultUrl/api/injections?ageId.in=$ageIdsString');
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
          injections.add(Injection.fromJson(d));
        });
        print(injections.map((e) => e.id));
        return injections;
      } catch(e) {
        print(e);
      }
      return injections;
    } catch (error) {
      return [];
    }
  }
}