import '../vaccine/vaccine.dart';
import '../immunization_unit/immunization_unit.dart';
import '../provider/provider.dart';


class VaccineLot {
  final int id;
  final String lotCode;
  final int quantity;
  final int quantityUsed;
  final DateTime expiredDate;
  final DateTime transactionDate;
  final DateTime manufacturingDate;
  final int salePrice;
  final Vaccine vaccine;
  final Provider provider;
  final ImmunizationUnit immunizationUnit;
  final int status;
  final String vaccinationType;

  VaccineLot({
    required this.id,
    required this.lotCode,
    required this.quantity,
    required this.quantityUsed,
    required this.expiredDate,
    required this.transactionDate,
    required this.manufacturingDate,
    required this.salePrice,
    required this.vaccine,
    required this.provider,
    required this.immunizationUnit,
    required this.status,
    required this.vaccinationType,
  });

  VaccineLot copyWith({
    int? id,
    String? lotCode,
    int? quantity,
    int? quantityUsed,
    DateTime? expiredDate,
    DateTime? transactionDate,
    DateTime? manufacturingDate,
    int? salePrice,
    Vaccine? vaccine,
    Provider? provider,
    ImmunizationUnit? immunizationUnit,
    int? status,
    String? vaccinationType,
  }) {
    return VaccineLot(
      id: id ?? this.id,
      lotCode: lotCode ?? this.lotCode,
      quantity: quantity ?? this.quantity,
      quantityUsed: quantityUsed ?? this.quantityUsed,
      expiredDate: expiredDate ?? this.expiredDate,
      transactionDate: transactionDate ?? this.transactionDate,
      manufacturingDate: manufacturingDate ?? this.manufacturingDate,
      salePrice: salePrice ?? this.salePrice,
      vaccine: vaccine ?? this.vaccine,
      provider: provider ?? this.provider,
      immunizationUnit: immunizationUnit ?? this.immunizationUnit,
      status: status ?? this.status,
      vaccinationType: vaccinationType ?? this.vaccinationType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lotCode': lotCode,
      'quantity': quantity,
      'quantityUsed': quantityUsed,
      'expiredDate': expiredDate.toIso8601String(),
      'transactionDate': transactionDate.toIso8601String(),
      'manufacturingDate': manufacturingDate.toIso8601String(),
      'salePrice': salePrice,
      'vaccine': vaccine.toJson(),
      'provider': provider.toJson(),
      'immunizationUnit': immunizationUnit.toJson(),
      'status': status,
      'vaccinationType': vaccinationType,
    };
  }

  static VaccineLot fromJson(Map<String, dynamic> json) {
    return VaccineLot(
      id: json['id'],
      lotCode: json['lotCode'],
      quantity: json['quantity'],
      quantityUsed: json['quantityUsed'],
      expiredDate: DateTime.parse(json['expiredDate']),
      transactionDate: DateTime.parse(json['transactionDate']),
      manufacturingDate: DateTime.parse(json['manufacturingDate']),
      salePrice: json['salePrice'],
      vaccine: Vaccine.fromJson(json['vaccine']),
      provider: Provider.fromJson(json['provider']),
      immunizationUnit: ImmunizationUnit.fromJson(json['immunizationUnit']),
      status: json['status'],
      vaccinationType: json['vaccinationType'],
    );
  }

  static List<VaccineLot> parseVaccineLotsList(List<dynamic> jsonList) {
    return jsonList.map((json) => VaccineLot.fromJson(json)).toList();
  }
}

