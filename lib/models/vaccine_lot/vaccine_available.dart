
class VaccineAvailable {
  final String id;
  final String name;
  final String vaccinationType;

  VaccineAvailable({
    required this.id,
    required this.name,
    required this.vaccinationType,
  });

  VaccineAvailable copyWith({
    String? id,
    String? name,
    String? vaccinationType,
  }) {
    return VaccineAvailable(
      id: id ?? this.id,
      name: name ?? this.name,
      vaccinationType: vaccinationType ?? this.vaccinationType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'vaccinationType': vaccinationType,
    };
  }

  static VaccineAvailable fromJson(Map<dynamic, dynamic> json) {
    return VaccineAvailable(
      id: json['id'],
      name: json['name'],
      vaccinationType: json['vaccinationType'],
    );
  }

  static List<VaccineAvailable> parseVaccinesList(List<dynamic> jsonList) {
    return jsonList.map((json) => VaccineAvailable.fromJson(json)).toList();
  }
}
