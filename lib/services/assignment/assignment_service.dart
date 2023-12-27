import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/assignment/assignment_for_diary.dart';
import '../../models/assignment/assignment.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class AssignmentService extends ApiService {
  AssignmentService([AuthToken? authToken]) : super (authToken);
  Future<List<AssignmentForDiary>> fetchAssignmentForDiaryByPatientId(String id) async {
    List<AssignmentForDiary> assignmentsForDiary = [];
    try {
      final url = Uri.parse('$defaultUrl/api/assignments/injection-for-diary/by-patient/$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        return [];
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      print(resultString);
      final resultMap =
      json.decode(resultString);
      print(resultMap);
      if (resultMap.isEmpty) {
        return [];
      }
      resultMap.forEach((data) {
        assignmentsForDiary.add(AssignmentForDiary.fromJson(data));
      });
      print("assignment for diary");
      print(assignmentsForDiary);
      return assignmentsForDiary;
    } catch (error) {
      return [];
    }
  }

  Future<List<Assignment>> fetchAssignmentsByIds(String ids) async {
    List<Assignment> assignments = [];
    try {
      final url = Uri.parse('$defaultUrl/api/assignments?id.in=$ids&page=0&size=500');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        return [];
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      print("assignment detail 1");
      print(resultString);
      final resultMap =
      json.decode(resultString);
      print(resultMap);
      if (resultMap.isEmpty) {
        return [];
      }
      resultMap.forEach((data) {
        assignments.add(Assignment.fromJson(data));
      });
      print("assignment detail 2");
      print(assignments);
      return assignments;
    } catch (error) {
      return [];
    }
  }

  Future<List<Assignment>> fetchAssignmentsByAppointmentCardId(int id) async {
    List<Assignment> assignments = [];
    try {
      final url = Uri.parse('$defaultUrl/api/assignments?appointmentCardId.equals=$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        return [];
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      print("assignment detail 1");
      print(resultString);
      final resultMap =
      json.decode(resultString);
      print(resultMap);
      if (resultMap.isEmpty) {
        return [];
      }
      resultMap.forEach((data) {
        assignments.add(Assignment.fromJson(data));
      });
      print("assignment detail 2");
      print(assignments);
      return assignments;
    } catch (error) {
      return [];
    }
  }
}