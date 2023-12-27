import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/disease/disease_general_information.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class DiseaseGeneralService extends ApiService {
  DiseaseGeneralService([AuthToken? authToken]) : super (authToken);

  Future<List<DiseaseGeneralInformation>>
      fetchDiseaseGeneralInformation() async {
    final List<DiseaseGeneralInformation> diseaseGeneralInformation = [];
    final List<String> test = [];
    try {
      final diseaseGeneralInformationUrl =  Uri.parse('$defaultUrl/api/diseases/select');
      final response = await http.get(
        diseaseGeneralInformationUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      print(diseaseGeneralInformationUrl);
      if (response.statusCode != 200) {
        return diseaseGeneralInformation;
      }
      print(utf8.decode(response.bodyBytes));
      final diseaseGeneralInformationUrlString =
        utf8.decode(response.bodyBytes);
      final diseaseGeneralInformationUrlMap = json.decode(diseaseGeneralInformationUrlString);
      print(diseaseGeneralInformationUrlMap);
        diseaseGeneralInformationUrlMap.forEach((d) {
        diseaseGeneralInformation.add(DiseaseGeneralInformation.fromJson(d));
      });
      print(diseaseGeneralInformation);
      return diseaseGeneralInformation;
    } catch (error) {
      return diseaseGeneralInformation;
    }
  }
}
