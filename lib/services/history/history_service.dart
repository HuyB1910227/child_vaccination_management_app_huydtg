import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/history/history.dart';
import '../../models/history/history_general_information.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class HistoryService extends ApiService {
  HistoryService([AuthToken? authToken]) : super (authToken);

  Future<List<HistoryGeneralInformation>> fetchAllHistoryForCustomer() async {
    final List<HistoryGeneralInformation> histories = [];
    try {
      final url = Uri.parse('$defaultUrl/api/customers/token/histories');
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
          histories.add(HistoryGeneralInformation.fromJson(d));
        });
        print(histories);
        return histories;
      } catch(e) {
        print(e);
      }
      return histories;
    } catch (error) {
      return [];
    }
  }

  Future<History?> fetchHistoryById(int id) async {

    try {
      final url = Uri.parse('$defaultUrl/api/histories/$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );

      if (response.statusCode != 200) {
        print("Not found history");
        return null;
      }
      final resultString =
      utf8.decode(response.bodyBytes);

      final resultMap =
      json.decode(resultString);
      print(resultMap);
      if (resultMap.isEmpty) {
        return null;
      }
      try{
        History history = History.fromJson(resultMap);
        print(history);
        return history;
      } catch(e) {
        print(e);
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}