import '../patient/patient.dart';
import '../immunization_unit/immunization_unit.dart';
import '../employee/employee.dart';
import 'package:timezone/timezone.dart';
class AppointmentCard {
  final int id;
  final DateTime appointmentDate;
  final DateTime? appointmentDateConfirmed;
  final int status;
  final String? note;
  final Patient patient;
  final ImmunizationUnit immunizationUnit;
  final Employee? employee;

  AppointmentCard({
    required this.id,
    required this.appointmentDate,
    this.appointmentDateConfirmed,
    required this.status,
    this.note,
    required this.patient,
    required this.immunizationUnit,
    this.employee,
  });

  AppointmentCard copyWith({
    int? id,
    DateTime? appointmentDate,
    DateTime? appointmentDateConfirmed,
    int? status,
    String? note,
    Patient? patient,
    ImmunizationUnit? immunizationUnit,
    Employee? employee,
  }) {
    return AppointmentCard(
      id: id ?? this.id,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentDateConfirmed:
      appointmentDateConfirmed ?? this.appointmentDateConfirmed,
      status: status ?? this.status,
      note: note ?? this.note,
      patient: patient ?? this.patient,
      immunizationUnit: immunizationUnit ?? this.immunizationUnit,
      employee: employee ?? this.employee,
    );
  }

  Map<String, dynamic> toJson() {

    return {
      'id': id,
      'appointmentDate': appointmentDate.toUtc().toIso8601String(),
      'appointmentDateConfirmed': appointmentDateConfirmed?.toIso8601String(),
      'status': status,
      'note': note,
      'patient': patient.toJson(),
      'immunizationUnit': immunizationUnit.toJson(),
      'employee': employee?.toJson(),
    };
  }

  Map<String, dynamic> toJsonNoneId() {

    return {
      'id': null,
      'appointmentDate': appointmentDate.toUtc().toIso8601String(),
      'appointmentDateConfirmed': appointmentDateConfirmed?.toIso8601String(),
      'status': status,
      'note': note,
      'patient': patient.toJson(),
      'immunizationUnit': immunizationUnit.toJson(),
      'employee': employee?.toJson(),
    };
  }

  static AppointmentCard fromJson(Map<String, dynamic> json) {
    DateTime appointmentDate = DateTime.parse(json['appointmentDate']);
    DateTime? appointmentDateConfirmed = json['appointmentDateConfirmed'] != null
        ? DateTime.parse(json['appointmentDateConfirmed'])
        : null;


    final vnTimeZone = getLocation('Asia/Ho_Chi_Minh');
    appointmentDate = TZDateTime.from(appointmentDate, vnTimeZone);
    if (appointmentDateConfirmed != null) {
      appointmentDateConfirmed = TZDateTime.from(appointmentDateConfirmed!, vnTimeZone);
    }
    return AppointmentCard(
      id: json['id'],

      appointmentDate: appointmentDate,
      appointmentDateConfirmed: appointmentDateConfirmed,
      status: json['status'],
      note: json['note'] ?? "Không có ghi chú",
      patient: Patient.fromJson(json['patient']),
      immunizationUnit: ImmunizationUnit.fromJson(json['immunizationUnit']),
      employee: json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }

  static List<AppointmentCard> parseAppointmentCardsList(List<dynamic> jsonList) {
    return jsonList.map((json) => AppointmentCard.fromJson(json)).toList();
  }
}

