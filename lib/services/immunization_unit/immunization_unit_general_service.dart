import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/immunization_unit/immunization_unit_general_information.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class ImmunizationUnitGeneralService extends ApiService {
  ImmunizationUnitGeneralService([AuthToken? authToken]) : super (authToken);

  Future<List<ImmunizationUnitGeneralInformation>> fetchAll() async {
    final List<ImmunizationUnitGeneralInformation> immunizations = [];
    try {
      print(accessToken);
      final url = Uri.parse('$defaultUrl/api/immunization-units/select');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        print("Not found immu");
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
          immunizations.add(ImmunizationUnitGeneralInformation.fromJson(d));
        });
        print(immunizations);
        return immunizations;
      } catch(e) {
        print(e);
      }
      return immunizations;
    } catch (error) {
      return [];
    }
  }
}
