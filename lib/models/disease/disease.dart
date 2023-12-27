import 'dart:convert';
import '../vaccine/vaccine.dart';
class Disease {
  final int id;
  final String name;
  final String description;
  final List<Vaccine>? vaccines;


  Disease({
    required this.id,
    required this.name,
    required this.description,
    this.vaccines
  });

  Disease copyWith({
    int? id,
    String? name,
    String? description,
    List<Vaccine>? vaccines
  }) {
    return Disease(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      vaccines: vaccines ?? this.vaccines
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'vaccines': vaccines,
    };
  }

  static Disease fromJson(Map<dynamic, dynamic> json) {
    // print(json);
    return Disease(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      vaccines: json['vaccines'] != null
          ? Vaccine.parseVaccinesList(json['vaccines'])
          : [],
    );
  }

  static List<Disease> parseDiseasesList(List<dynamic> jsonList) {
    return jsonList.map((json) => Disease.fromJson(json)).toList();
  }



}