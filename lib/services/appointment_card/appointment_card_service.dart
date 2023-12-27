import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/appointment_card/appointment_card.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';

class AppointmentCardService extends ApiService {
  AppointmentCardService([AuthToken? authToken]) : super (authToken);
  Future<List<AppointmentCard>> fetchAppointmentCardToScheduleExpected() async {
    final List<AppointmentCard> appointmentCards = [];
    try {
      final url = Uri.parse('$defaultUrl/api/appointment-cards/schedule-expected');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        print("Not found appointmentCard");
        return [];
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      final resultMap =
      json.decode(resultString);
      if (resultMap.isEmpty) {
        return [];
      }
      try{
        resultMap.forEach((d) {
          appointmentCards.add(AppointmentCard.fromJson(d));
        });
        return appointmentCards;
      } catch(e) {
        print(e);
      }
      return appointmentCards;
    } catch (error) {
      return [];
    }
  }

  Future<List<AppointmentCard>> fetchAppointmentCardToScheduleRegistered() async {
    final List<AppointmentCard> appointmentCards = [];
    try {
      final url = Uri.parse('$defaultUrl/api/appointment-cards/schedule-registered');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        print("Not found appointmentCard");
        return [];
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      final resultMap =
      json.decode(resultString);
      if (resultMap.isEmpty) {
        return [];
      }
      try{
        resultMap.forEach((d) {
          appointmentCards.add(AppointmentCard.fromJson(d));
        });
        print(appointmentCards);
        return appointmentCards;
      } catch(e) {
        print(e);
      }
      return appointmentCards;
    } catch (error) {
      return [];
    }
  }

  Future<AppointmentCard?> fetchById(int id) async {
    try {
      final url = Uri.parse('$defaultUrl/api/appointment-cards/${id}');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        print("Not found appointmentCard");
        return null;
      }
      final resultString =
      utf8.decode(response.bodyBytes);
      final resultMap =
      json.decode(resultString);
      if (resultMap.isEmpty) {
        return null;
      }
      final appointmentCard = AppointmentCard.fromJson(resultMap);
      return appointmentCard;
    } catch (error) {
      return null;
    }
  }

  Future<AppointmentCard?> createAppointmentCard(AppointmentCard appointmentCard) async {
    try {
      final url = Uri.parse('$defaultUrl/api/appointment-cards');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
        body: json.encode(appointmentCard.toJsonNoneId()),
      );
      print(json.encode(appointmentCard.toJsonNoneId()));
      if (response.statusCode != 201) {
        print("can not create appointment card");
        return null;
      }
      final responseDataString =
      utf8.decode(response.bodyBytes);
      final responseDataMap =
      json.decode(responseDataString);
      final patientUpdated = AppointmentCard.fromJson(responseDataMap);
      print("created appointment card");
      return patientUpdated;
    } catch (error) {
      return null;
    }
  }
}