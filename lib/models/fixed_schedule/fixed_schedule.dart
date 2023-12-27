import '../immunization_unit/immunization_unit.dart';
import 'package:timezone/timezone.dart';
class FixedSchedule {
  final int id;
  final String workingDay;
  final String workingWeek;
  final String workingDayType;
  final String workingWeekType;
  final String vaccinationType;
  final String? note;
  final bool isEnable;
  final DateTime startTime;
  final DateTime endTime;
  final ImmunizationUnit immunizationUnit;

  FixedSchedule({
    required this.id,
    required this.workingDay,
    required this.workingWeek,
    required this.workingDayType,
    required this.workingWeekType,
    required this.vaccinationType,
    this.note,
    required this.isEnable,
    required this.startTime,
    required this.endTime,
    required this.immunizationUnit,
  });

  FixedSchedule copyWith({
    int? id,
    String? workingDay,
    String? workingWeek,
    String? workingDayType,
    String? workingWeekType,
    String? vaccinationType,
    String? note,
    bool? isEnable,
    DateTime? startTime,
    DateTime? endTime,
    ImmunizationUnit? immunizationUnit,
  }) {
    return FixedSchedule(
      id: id ?? this.id,
      workingDay: workingDay ?? this.workingDay,
      workingWeek: workingWeek ?? this.workingWeek,
      workingDayType: workingDayType ?? this.workingDayType,
      workingWeekType: workingWeekType ?? this.workingWeekType,
      vaccinationType: vaccinationType ?? this.vaccinationType,
      note: note ?? this.note,
      isEnable: isEnable ?? this.isEnable,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      immunizationUnit: immunizationUnit ?? this.immunizationUnit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workingDay': workingDay,
      'workingWeek': workingWeek,
      'workingDayType': workingDayType,
      'workingWeekType': workingWeekType,
      'vaccinationType': vaccinationType,
      'note': note,
      'isEnable': isEnable,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'immunizationUnit': immunizationUnit.toJson(),
    };
  }

  static FixedSchedule fromJson(Map<String, dynamic> json) {
    DateTime startTime = DateTime.parse(json['startTime']);
    DateTime endTime = DateTime.parse(json['endTime']);
    final vnTimeZone = getLocation('Asia/Ho_Chi_Minh');
    startTime = TZDateTime.from(startTime, vnTimeZone);
    endTime = TZDateTime.from(endTime, vnTimeZone);
    return FixedSchedule(
      id: json['id'],
      workingDay: json['workingDay'],
      workingWeek: json['workingWeek'],
      workingDayType: json['workingDayType'],
      workingWeekType: json['workingWeekType'],
      vaccinationType: json['vaccinationType'],
      note: json['note'],
      isEnable: json['isEnable'],
      startTime: startTime,
      endTime: endTime,
      immunizationUnit: ImmunizationUnit.fromJson(json['immunizationUnit']),
    );
  }
}
