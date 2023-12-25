import '../vaccine/vaccine.dart';

class Age {
  final int id;
  final int minAge;
  final String minAgeType;
  final int? maxAge;
  final String? maxAgeType;
  final Vaccine vaccine;


  Age({
    required this.id,
    required this.minAge,
    required this.minAgeType,
    this.maxAge,
    this.maxAgeType,
    required this.vaccine,
  });

  Age copyWith({
    int? id,
    int? minAge,
    String? minAgeType,
    int? maxAge,
    String? maxAgeType,
    Vaccine? vaccine,
  }) {
    return Age(
      id: id ?? this.id,
      minAge: minAge ?? this.minAge,
      minAgeType: minAgeType ?? this.minAgeType,
      maxAge: maxAge ?? this.maxAge,
      maxAgeType: maxAgeType ?? this.maxAgeType,
      vaccine: vaccine ?? this.vaccine,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'minAge': minAge,
      'minAgeType': minAgeType,
      'maxAge': maxAge,
      'maxAgeType': maxAgeType,
      'vaccine': vaccine.toJson(),
    };
  }

  static Age fromJson(Map<dynamic, dynamic> json) {
    return Age(
      id: json['id'],
      minAge: json['minAge'],
      minAgeType: json['minAgeType'],
      maxAge: json['maxAge'],
      maxAgeType: json['maxAgeType'],
      vaccine: Vaccine.fromJson(json['vaccine']),
    );
  }

}