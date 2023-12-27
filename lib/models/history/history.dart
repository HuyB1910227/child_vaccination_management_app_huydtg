import '../appointment_card/appointment_card.dart';
import '../patient/patient.dart';

class History {
  final int id;
  final DateTime vaccinationDate;
  final String? statusAfterInjection;
  final AppointmentCard appointmentCard;
  final Patient patient;

  History({
    required this.id,
    required this.vaccinationDate,
    required this.statusAfterInjection,
    required this.appointmentCard,
    required this.patient,
  });

  History copyWith({
    int? id,
    DateTime? vaccinationDate,
    String? statusAfterInjection,
    AppointmentCard? appointmentCard,
    Patient? patient,
  }) {
    return History(
      id: id ?? this.id,
      vaccinationDate: vaccinationDate ?? this.vaccinationDate,
      statusAfterInjection: statusAfterInjection ?? this.statusAfterInjection,
      appointmentCard: appointmentCard ?? this.appointmentCard,
      patient: patient ?? this.patient,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vaccinationDate': vaccinationDate.toIso8601String(),
      'statusAfterInjection': statusAfterInjection,
      'appointmentCard': appointmentCard.toJson(),
      'patient': patient.toJson(),
    };
  }

  static History fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      vaccinationDate: DateTime.parse(json['vaccinationDate']),
      statusAfterInjection: json['statusAfterInjection'],
      appointmentCard: AppointmentCard.fromJson(json['appointmentCard']),
      patient: Patient.fromJson(json['patient']),
    );
  }

  static List<History> parseProvidersList(List<dynamic> jsonList) {
    return jsonList.map((json) => History.fromJson(json)).toList();
  }
}
