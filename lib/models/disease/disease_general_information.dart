class DiseaseGeneralInformation {
  final int id;
  final String name;

  DiseaseGeneralInformation({
    required this.id,
    required this.name,
  });

  DiseaseGeneralInformation copyWith({
    int? id,
    String? name,
  }) {
    return DiseaseGeneralInformation(
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

  static DiseaseGeneralInformation fromJson(Map<dynamic, dynamic> json) {
    print(json);
    return DiseaseGeneralInformation(
      id: json['id'],
      name: json['name'],
    );
  }
}
