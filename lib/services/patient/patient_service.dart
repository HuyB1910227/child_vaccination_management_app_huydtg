import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/patient/patient.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class PatientService extends ApiService {
  PatientService([AuthToken? authToken]) : super (authToken);

  Future<Patient?> fetchPatientById(String id) async {
    try {
      final url = Uri.parse('$defaultUrl/api/patients/$id');
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
      final patient = Patient.fromJson(responseDataMap);
      return patient;
    } catch (error) {
      return null;
    }
  }

  Future<Patient?> partialUpdate(Patient patient) async {

    try {
      final url = Uri.parse('$defaultUrl/api/patients/${patient.id}');
      // print(url);
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
        body: json.encode(patient.toJson()),
      );
      print(json.encode(patient.toJson()));
      print(response.headers);
      if (response.statusCode != 200) {
        print("can not update patient");
        return null;
      }
      final responseDataString =
      utf8.decode(response.bodyBytes);
      final responseDataMap =
      json.decode(responseDataString);
      if (responseDataMap.isEmpty) {
        return null;
      }
      final patientUpdated = Patient.fromJson(responseDataMap);
      print("updated patient");
      // print(patient);
      return patientUpdated;
    } catch (error) {
      return null;
    }
  }

}
