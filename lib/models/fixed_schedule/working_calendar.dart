import 'package:timezone/timezone.dart';
class WorkingCalendar {
  final DateTime date;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String? note;
  final int fixedScheduleId;
  final String vaccinationType;

  WorkingCalendar({
    required this.date,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.note,
    required this.fixedScheduleId,
    required this.vaccinationType,
  });

  WorkingCalendar copyWith({
    DateTime? date,
    String? title,
    DateTime? startTime,
    DateTime? endTime,
    String? note,
    int? fixedScheduleId,
    String? vaccinationType,
  }) {
    return WorkingCalendar(
      date: date ?? this.date,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      note: note ?? this.note,
      fixedScheduleId: fixedScheduleId ?? this.fixedScheduleId,
      vaccinationType: vaccinationType ?? this.vaccinationType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'note': note,
      'fixedScheduleId': fixedScheduleId,
      'vaccinationType': vaccinationType,
    };
  }

  static WorkingCalendar fromJson(Map<String, dynamic> json) {
    DateTime startTime = DateTime.parse(json['startTime']);
    DateTime endTime = DateTime.parse(json['endTime']);
    final vnTimeZone = getLocation('Asia/Ho_Chi_Minh');
    startTime = TZDateTime.from(startTime, vnTimeZone);
    endTime = TZDateTime.from(endTime, vnTimeZone);
    return WorkingCalendar(
      date: DateTime.parse(json['date']),
      title: json['title'],
      startTime: startTime,
      endTime: endTime,
      note: json['note'],
      fixedScheduleId: json['fixedScheduleId'],
      vaccinationType: json['vaccinationType'],
    );
  }
}
