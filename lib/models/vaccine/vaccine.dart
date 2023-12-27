import '../disease/disease.dart';
import '../vaccine_type/vaccine_type.dart';
class Vaccine {
  final String id;
  final String name;
  final double dosage;
  final String commonReaction;
  final List<Disease>? diseases;
  final VaccineType vaccineType;
  final String description;
  final String contraindication;

  Vaccine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.commonReaction,
    this.diseases,
    required this.vaccineType,
    required this.description,
    required this.contraindication,
  });

  Vaccine copyWith({
    String? id,
    String? name,
    double? dosage,
    String? commonReaction,
    List<Disease>? diseases,
    VaccineType? vaccineType,
    String? description,
    String? contraindication,

  }) {
    return Vaccine(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      commonReaction: commonReaction ?? this.commonReaction,
      diseases: diseases ?? this.diseases,
      vaccineType: vaccineType ?? this.vaccineType,
      description: description ?? this.description,
      contraindication: contraindication ?? this.contraindication,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'commonReaction': commonReaction,
      'disease': diseases,
      'vaccineType': vaccineType.toJson(),
      'description': description,
      'contraindication': contraindication,
    };
  }

  static Vaccine fromJson(Map<dynamic, dynamic> json) {
    return Vaccine(
      id: json['id'],
      name: json['name'],
      dosage: json['dosage'],
      commonReaction: json['commonReaction'],
      diseases: Disease.parseDiseasesList(json['diseases']),
      vaccineType: VaccineType.fromJson(json['vaccineType']),
      description: json['description'],
      contraindication: json['contraindication'],
    );
  }

  static List<Vaccine> parseVaccinesList(List<dynamic> jsonList) {
    return jsonList.map((json) => Vaccine.fromJson(json)).toList();
  }

}