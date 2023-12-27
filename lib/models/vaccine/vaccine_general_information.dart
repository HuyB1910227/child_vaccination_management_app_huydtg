class VaccineGeneralInformation {
  final String id;
  final String name;

  VaccineGeneralInformation({
    required this.id,
    required this.name,
  });

  VaccineGeneralInformation copyWith({
    String? id,
    String? name,
  }) {
    return VaccineGeneralInformation(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static VaccineGeneralInformation fromJson(Map<dynamic, dynamic> json) {
    return VaccineGeneralInformation(
      id: json['id'],
      name: json['name'],
    );
  }
}
