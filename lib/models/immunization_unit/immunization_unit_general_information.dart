class ImmunizationUnitGeneralInformation {
  final String id;
  final String name;
  final String address;
  final bool isActive;

  ImmunizationUnitGeneralInformation({
    required this.id,
    required this.name,
    required this.address,
    required this.isActive
  });

  ImmunizationUnitGeneralInformation copyWith({
    String? id,
    String? name,
    String? address,
    bool? isActive
  }) {
    return ImmunizationUnitGeneralInformation(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'isActive': isActive,
    };
  }

  static ImmunizationUnitGeneralInformation fromJson(Map<dynamic, dynamic> json) {
    return ImmunizationUnitGeneralInformation(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      isActive: json['isActive'],
    );
  }
}
