class Nutrition {
  final int id;
  final double weight;
  final double height;
  final DateTime measurementDate;
  final String status;

  Nutrition({
    required this.id,
    required this.weight,
    required this.height,
    required this.measurementDate,
    required this.status,
  });

  Nutrition copyWith({
    int? id,
    double? weight,
    double? height,
    DateTime? measurementDate,
    String? status,
  }) {
    return Nutrition(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      measurementDate: measurementDate ?? this.measurementDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'height': height,
      'measurementDate': measurementDate.toIso8601String(),
      'status': status,
    };
  }

  static Nutrition fromJson(Map<String, dynamic> json) {
    return Nutrition(
      id: json['id'],
      weight: json['weight'],
      height: json['height'],
      measurementDate: DateTime.parse(json['measurementDate']),
      status: json['status'],
    );
  }
}
