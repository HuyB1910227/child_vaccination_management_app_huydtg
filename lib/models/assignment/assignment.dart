import '../appointment_card/appointment_card.dart';
import '../vaccine_lot/vaccine_lot.dart';
import 'package:timezone/timezone.dart';
class Assignment {
  final int id;
  final String? route;
  final int injectionTime;
  final int status;
  final int price;
  final DateTime? injectionCompletionTime;
  final AppointmentCard appointmentCard;
  final VaccineLot vaccineLot;

  Assignment({
    required this.id,
    this.route,
    required this.injectionTime,
    required this.status,
    required this.price,
    this.injectionCompletionTime,
    required this.appointmentCard,
    required this.vaccineLot,
  });

  Assignment copyWith({
    int? id,
    String? route,
    int? injectionTime,
    int? status,
    int? price,
    DateTime? injectionCompletionTime,
    AppointmentCard? appointmentCard,
    VaccineLot? vaccineLot,
  }) {
    return Assignment(
      id: id ?? this.id,
      route: route ?? this.route,
      injectionTime: injectionTime ?? this.injectionTime,
      status: status ?? this.status,
      price: price ?? this.price,
      injectionCompletionTime: injectionCompletionTime ?? this.injectionCompletionTime,
      appointmentCard: appointmentCard ?? this.appointmentCard,
      vaccineLot: vaccineLot ?? this.vaccineLot,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'route': route,
      'injectionTime': injectionTime,
      'status': status,
      'price': price,
      'injectionCompletionTime': injectionCompletionTime?.toIso8601String(),
      'appointmentCard': appointmentCard.toJson(),
      'vaccineLot': vaccineLot.toJson(),
    };
  }

  static Assignment fromJson(Map<dynamic, dynamic> json) {
    DateTime? injectionCompletionTime = json['injectionCompletionTime'] != null
        ? DateTime.parse(json['injectionCompletionTime'])
        : null;
    final vnTimeZone = getLocation('Asia/Ho_Chi_Minh');
    if (injectionCompletionTime != null) {
      injectionCompletionTime = TZDateTime.from(injectionCompletionTime, vnTimeZone);
    }
    return Assignment(
      id: json['id'],
      route: json['route'],
      injectionTime: json['injectionTime'],
      status: json['status'],
      price: json['price'],
      injectionCompletionTime: injectionCompletionTime,
      appointmentCard: AppointmentCard.fromJson(json['appointmentCard']),
      vaccineLot: VaccineLot.fromJson(json['vaccineLot']),
    );
  }

  static List<Assignment> parseAssignmentsList(List<dynamic> jsonList) {
    return jsonList.map((json) => Assignment.fromJson(json)).toList();
  }
}
