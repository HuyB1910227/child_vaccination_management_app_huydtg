import '../age/age.dart';

class Injection {
  final int id;
  final int injectionTime;
  final int distanceFromPrevious;
  final String distanceFromPreviousType;
  final Age age;


  Injection({
    required this.id,
    required this.injectionTime,
    required this.distanceFromPrevious,
    required this.distanceFromPreviousType,
    required this.age,
  });

  Injection copyWith({
    int? id,
    int? injectionTime,
    int? distanceFromPrevious,
    String? distanceFromPreviousType,
    Age? age,
  }) {
    return Injection(
      id: id ?? this.id,
      injectionTime: injectionTime ?? this.injectionTime,
      distanceFromPrevious: distanceFromPrevious ?? this.distanceFromPrevious,
      distanceFromPreviousType: distanceFromPreviousType ?? this.distanceFromPreviousType,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'injectionTime': injectionTime,
      'distanceFromPrevious': distanceFromPrevious,
      'distanceFromPreviousType': distanceFromPreviousType,
      'age': age.toJson(),
    };
  }

  static Injection fromJson(Map<dynamic, dynamic> json) {
    return Injection(
      id: json['id'],
      injectionTime: json['injectionTime'],
      distanceFromPrevious: json['distanceFromPrevious'],
      distanceFromPreviousType: json['distanceFromPreviousType'],
      age: Age.fromJson(json['age']),
    );
  }
}