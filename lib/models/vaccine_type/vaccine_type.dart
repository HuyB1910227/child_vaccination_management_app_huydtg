
class VaccineType {
  final int id;
  final String name;


  VaccineType({
    required this.id,
    required this.name,
  });

  VaccineType copyWith({
    int? id,
    String? name,

  }) {
    return VaccineType(
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

  static VaccineType fromJson(Map<dynamic, dynamic> json) {
    return VaccineType(
      id: json['id'],
      name: json['name'],
    );
  }


}