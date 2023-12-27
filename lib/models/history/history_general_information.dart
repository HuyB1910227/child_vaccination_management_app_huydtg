import '../patient/patient_general_information.dart';
import 'package:timezone/timezone.dart';
class HistoryGeneralInformation {
  final int id;
  final DateTime vaccinationDate;
  final String? statusAfterInjection;
  final PatientGeneralInformation patientGeneralInformation;

  HistoryGeneralInformation({
    required this.id,
    required this.vaccinationDate,
    this.statusAfterInjection,
    required this.patientGeneralInformation,
  });

  HistoryGeneralInformation copyWith({
    int? id,
    DateTime? vaccinationDate,
    String? statusAfterInjection,
    PatientGeneralInformation? patientGeneralInformation,
  }) {
    return HistoryGeneralInformation(
      id: id ?? this.id,
      vaccinationDate: vaccinationDate ?? this.vaccinationDate,
      statusAfterInjection: statusAfterInjection ?? this.statusAfterInjection,
      patientGeneralInformation: patientGeneralInformation ?? this.patientGeneralInformation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vaccinationDate': vaccinationDate.toIso8601String(),
      'statusAfterInjection': statusAfterInjection,
      'patient': patientGeneralInformation.toJson(),
    };
  }

  static HistoryGeneralInformation fromJson(Map<String, dynamic> json) {
    DateTime vaccinationDate = DateTime.parse(json['vaccinationDate']);
    final vnTimeZone = getLocation('Asia/Ho_Chi_Minh');
    vaccinationDate = TZDateTime.from(vaccinationDate, vnTimeZone);
    return HistoryGeneralInformation(
      id: json['id'],
      vaccinationDate: vaccinationDate,
      statusAfterInjection: json['statusAfterInjection'],
      patientGeneralInformation: PatientGeneralInformation.fromJson(json['patientGeneralInformation']),
    );
  }

  static List<HistoryGeneralInformation> parseHistoriesList(List<dynamic> jsonList) {
    return jsonList.map((json) => HistoryGeneralInformation.fromJson(json)).toList();
  }
}
