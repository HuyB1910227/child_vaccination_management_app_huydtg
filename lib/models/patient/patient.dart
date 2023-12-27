import 'patient_general_information.dart';

class Patient {
  final String id;
  final String fullName;
  final DateTime dateOfBirth;
  final int gender;
  final String address;
  final String? avatar;

  Patient({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    this.avatar,
  });

  Patient copyWith({
    String? id,
    String? fullName,
    DateTime? dateOfBirth,
    int? gender,
    String? address,
    String? avatar
  }) {
    return Patient(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        avatar: avatar ?? this.avatar
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'address': address,
      'avatar': avatar,
    };
  }

  static Patient fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      fullName: json['fullName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      address: json['address'],
      avatar: json['avatar'],
    );
  }

  static Patient fromPatientGeneralInformation(PatientGeneralInformation patientGeneralInformation) {
    return Patient(
        id: patientGeneralInformation.id,
        fullName: patientGeneralInformation.fullName,
        dateOfBirth: patientGeneralInformation.dateOfBirth,
        gender: patientGeneralInformation.gender,
        address: patientGeneralInformation.address
    );
  }

}
