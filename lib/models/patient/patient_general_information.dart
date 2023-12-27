class PatientGeneralInformation {
  final String id;
  final String fullName;
  final DateTime dateOfBirth;
  final int gender;
  final String address;
  final String? avatar;

  PatientGeneralInformation({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    this.avatar,
  });

  PatientGeneralInformation copyWith({
    String? id,
    String? fullName,
    DateTime? dateOfBirth,
    int? gender,
    String? address,
    String? avatar
  }) {
    return PatientGeneralInformation(
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
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'address': address,
      'avatar': avatar,
    };
  }

  static PatientGeneralInformation fromJson(Map<String, dynamic> json) {
    return PatientGeneralInformation(
      id: json['id'],
      fullName: json['fullName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      address: json['address'],
      avatar: json['avatar'],
    );
  }

}
