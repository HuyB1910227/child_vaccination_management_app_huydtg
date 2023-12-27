class Customer {
  final String id;
  final String phone;
  final String? email;
  final String fullName;
  final String identityCard;
  final DateTime dateOfBirth;
  final int gender;
  final String address;
  final String? career;
  final String? avatar;

  Customer({
    required this.id,
    required this.phone,
    required this.email,
    required this.fullName,
    required this.identityCard,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.career,
    this.avatar,
  });

  Customer copyWith({
    String? id,
    String? phone,
    String? email,
    String? fullName,
    String? identityCard,
    DateTime? dateOfBirth,
    int? gender,
    String? address,
    String? career,
    String? avatar,
  }) {
    return Customer(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      identityCard: identityCard ?? this.identityCard,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      career: career ?? this.career,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'fullName': fullName,
      'identityCard': identityCard,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'address': address,
      'career': career,
      'avatar': avatar,
    };
  }

  static Customer fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      phone: json['phone'],
      email: json['email'],
      fullName: json['fullName'],
      identityCard: json['identityCard'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      address: json['address'],
      career: json['career'],
      avatar: json['avatar'],
    );
  }

  static List<Customer> parseEmployeesList(List<dynamic> jsonList) {
    return jsonList.map((json) => Customer.fromJson(json)).toList();
  }
}
