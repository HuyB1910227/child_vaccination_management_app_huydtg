import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/fixed_schedule/working_calendar.dart';
import '../../models/fixed_schedule/fixed_schedule.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class FixedScheduleService extends ApiService {
  FixedScheduleService([AuthToken? authToken]) : super (authToken);

  Future<List<FixedSchedule>> fetchFixedScheduleByImmunizationUnitId(String immunizationUnitId) async {
    print("Tìm kiếm giai đoạn");
    final List<FixedSchedule> fixedSchedules = [];
    try {
      print(accessToken);
      final url = Uri.parse('$defaultUrl/api/fixed-schedules?immunizationUnitId.equals=$immunizationUnitId');
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
          fixedSchedules.add(FixedSchedule.fromJson(d));
        });
        print(fixedSchedules);
        return fixedSchedules;
      } catch(e) {
        print(e);
      }
      print("founded fixed schedule");
      print(fixedSchedules);
      return fixedSchedules;
    } catch (error) {
      return [];
    }
  }

  Future<List<WorkingCalendar>> fetchWorkingCalendar(Map<String, dynamic> request) async {
    final List<WorkingCalendar> workingCalendars = [];
    try {
      final url = Uri.parse('$defaultUrl/api/fixed-schedules/work-schedule/all}');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
        body: json.encode(request),
      );
      print(json.encode(request));
      print(response.headers);
      if (response.statusCode != 200) {
        print("can not find working schedule");
        return workingCalendars;
      }
      final responseDataString =
      utf8.decode(response.bodyBytes);
      final responseDataMap =
      json.decode(responseDataString);
      if (responseDataMap.isEmpty) {
        return workingCalendars;
      }
      try{
        responseDataMap.forEach((d) {
          workingCalendars.add(WorkingCalendar.fromJson(d));
        });
        print(workingCalendars);
        return workingCalendars;
      } catch(e) {
        print(e);
      }
      print("updated patient");
      return workingCalendars;
    } catch (error) {
      return [];
    }
  }

  Future<List<FixedSchedule>> fetchFixedScheduleCurrently() async {
    final List<FixedSchedule> fixedSchedules = [];
    try {
      print(accessToken);
      final url = Uri.parse('$defaultUrl/api/fixed-schedules/work-schedule/today');
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
          fixedSchedules.add(FixedSchedule.fromJson(d));
        });
        print(fixedSchedules);
        return fixedSchedules;
      } catch(e) {
        print(e);
      }
      print("founded fixed schedule");
      print(fixedSchedules);
      return fixedSchedules;
    } catch (error) {
      return [];
    }
  }
}