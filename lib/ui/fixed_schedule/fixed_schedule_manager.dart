import '../../models/auth_token.dart';
import '../../models/fixed_schedule/fixed_schedule.dart';
import '../../models/fixed_schedule/working_calendar.dart';
import '../../services/fixed_schedule/fixed_schedule_service.dart';
import 'package:flutter/foundation.dart';

class FixedScheduleManager with ChangeNotifier {
  final FixedScheduleService _fixedScheduleService;

  List<WorkingCalendar> _workingCalendars = [];

  Map<DateTime, List<WorkingCalendar>> _events = {};

  FixedScheduleManager([AuthToken? authToken])
      : _fixedScheduleService = FixedScheduleService(authToken);

  set authToken(AuthToken? authToken) {
    _fixedScheduleService.authToken = authToken;
  }

  Future<List<FixedSchedule>> fetchFixedScheduleByImmunizationUnitId(
      String id) async {
    print("call fixed schedule");
    List<FixedSchedule> result =
        await _fixedScheduleService.fetchFixedScheduleByImmunizationUnitId(id);
    return result;
  }

  Future<List<FixedSchedule>> fetchFixedScheduleCurrently() async {
    return await _fixedScheduleService.fetchFixedScheduleCurrently();
  }

  Future<void> fetchAllWorkingCalendarInRange(
      String immunizationUnitId, DateTime fromDate, DateTime toDate) async {
    String fromDateInstant = fromDate.toUtc().toIso8601String();
    String toDateInstant = toDate.toUtc().toIso8601String();
    final Map<String, dynamic> request = {
      "immunizationUnitId": immunizationUnitId,
      "isEnable": true,
      "fromDate": fromDateInstant,
      "toDate": toDateInstant,
    };
    _workingCalendars =
        await _fixedScheduleService.fetchWorkingCalendar(request);

    _events = {};
    if (_workingCalendars.isNotEmpty) {
      for (var calendar in _workingCalendars) {
        final listEvent = findWorkingTimeInDay(calendar.date);
        DateTime keyDateTime = DateTime.utc(
          calendar.date.year,
          calendar.date.month,
          calendar.date.day,
          0,
          0,
          0,
          0,
        );
        _events[keyDateTime] = listEvent;
      }
    }

    notifyListeners();
  }

  List<WorkingCalendar> get workingCalendars {
    return [..._workingCalendars];
  }

  Map<DateTime, List<WorkingCalendar>> get event {
    return _events;
  }

  List<WorkingCalendar> findWorkingTimeInDay(DateTime selectedDay) {
    List<WorkingCalendar> result = [];
    for (var calendar in _workingCalendars) {
      if (calendar.date.year == selectedDay.year &&
          calendar.date.month == selectedDay.month &&
          calendar.date.day == selectedDay.day) {
        result.add(calendar);
      }
    }
    return result;
  }
}
