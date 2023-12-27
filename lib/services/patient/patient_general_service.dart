import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/patient/patient_general_information.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class PatientGeneralService extends ApiService {
  PatientGeneralService([AuthToken? authToken]) : super (authToken);

  Future<List<PatientGeneralInformation>>
      fetchPatientGeneralInformation() async {
    final List<PatientGeneralInformation> patientGeneralInformation = [];
    try {
      final patientGeneralInformationUrl =
          Uri.parse('$defaultUrl/api/customers/token/patients');
      final response = await http.get(
        patientGeneralInformationUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      print(patientGeneralInformationUrl);
      print(accessToken);
      print(utf8.decode(response.bodyBytes));
      print(response.statusCode);
      if (response.statusCode != 200) {
        print("Not found patients");
        return patientGeneralInformation;
      }
      final patientGeneralInformationUrlString =
        utf8.decode(response.bodyBytes);
      final patientGeneralInformationUrlMap = json.decode(patientGeneralInformationUrlString);
      print(patientGeneralInformationUrlMap);
      patientGeneralInformationUrlMap.forEach((patient) {
        print(patient);
        patientGeneralInformation.add(PatientGeneralInformation.fromJson(patient));
      });
      print(patientGeneralInformation);
      return patientGeneralInformation;
    } catch (error) {
      return patientGeneralInformation;
    }
  }
}
