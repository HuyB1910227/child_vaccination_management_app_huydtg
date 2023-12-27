class Employee {
  final String id;
  final String employeeId;
  final String phone;
  final String email;
  final String fullName;
  final String identityCard;
  final DateTime dateOfBirth;
  final int gender;
  final String address;
  final String? avatar;

  Employee({
    required this.id,
    required this.employeeId,
    required this.phone,
    required this.email,
    required this.fullName,
    required this.identityCard,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    this.avatar,
  });

  Employee copyWith({
    String? id,
    String? employeeId,
    String? phone,
    String? email,
    String? fullName,
    String? identityCard,
    DateTime? dateOfBirth,
    int? gender,
    String? address,
    String? avatar,
  }) {
    return Employee(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      identityCard: identityCard ?? this.identityCard,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'phone': phone,
      'email': email,
      'fullName': fullName,
      'identityCard': identityCard,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'address': address,
      'avatar': avatar,
    };
  }

  static Employee fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employeeId: json['employeeId'],
      phone: json['phone'],
      email: json['email'],
      fullName: json['fullName'],
      identityCard: json['identityCard'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      address: json['address'],
      avatar: json['avatar'],
    );
  }

  static List<Employee> parseEmployeesList(List<dynamic> jsonList) {
    return jsonList.map((json) => Employee.fromJson(json)).toList();
  }
}
