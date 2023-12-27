class ImmunizationUnit {
  final String id;
  final String name;
  final String address;
  final String operatingLicence;
  final String hotline;
  final bool isActive;
  final double? latitude;
  final double? longitude;

  ImmunizationUnit({
    required this.id,
    required this.name,
    required this.address,
    required this.operatingLicence,
    required this.hotline,
    required this.isActive,
    this.latitude,
    this.longitude,
  });

  ImmunizationUnit copyWith({
    String? id,
    String? name,
    String? address,
    String? operatingLicence,
    String? hotline,
    bool? isActive,
    double? latitude,
    double? longitude,
  }) {
    return ImmunizationUnit(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      operatingLicence: operatingLicence ?? this.operatingLicence,
      hotline: hotline ?? this.hotline,
      isActive: isActive ?? this.isActive,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'operatingLicence': operatingLicence,
      'hotline': hotline,
      'isActive': isActive,
      'latitude': latitude,
      'longitude': longitude,
    };
  }


  static ImmunizationUnit fromJson(Map<dynamic, dynamic> json) {
    return ImmunizationUnit(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      operatingLicence: json['operatingLicence'],
      hotline: json['hotline'],
      isActive: json['isActive'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}