import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/vaccine/vaccine_general_information.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class VaccineGeneralService extends ApiService {
  VaccineGeneralService([AuthToken? authToken]) : super (authToken);
  Future<List<VaccineGeneralInformation>>
  fetchVaccineGeneralInformation() async {
    final List<VaccineGeneralInformation> vaccineGeneralInformation = [];
    final List<String> test = [];
    try {
      final vaccineGeneralInformationUrl =  Uri.parse('$defaultUrl/api/vaccines/select');
      final response = await http.get(
        vaccineGeneralInformationUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      print(vaccineGeneralInformationUrl);
      if (response.statusCode != 200) {
        return vaccineGeneralInformation;
      }
      print(utf8.decode(response.bodyBytes));
      final vaccineGeneralInformationUrlString =
      utf8.decode(response.bodyBytes);
      final vaccineGeneralInformationUrlMap = json.decode(vaccineGeneralInformationUrlString);
      print(vaccineGeneralInformationUrlMap);
      vaccineGeneralInformationUrlMap.forEach((d) {
        vaccineGeneralInformation.add(VaccineGeneralInformation.fromJson(d));
      });
      print(vaccineGeneralInformation);
      return vaccineGeneralInformation;
    } catch (error) {
      return vaccineGeneralInformation;
    }
  }
}