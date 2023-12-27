import 'package:flutter/material.dart';
import 'appointment_card_registered_card.dart';
import '../../../models/appointment_card/appointment_card.dart';

class AppointmentCardRegisteredSearchDelegate extends SearchDelegate<String> {
  final List<AppointmentCard> appointmentCards;

  AppointmentCardRegisteredSearchDelegate(this.appointmentCards);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () { query = ''; }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () { close(context, ""); },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final lowercaseQuery = query.toLowerCase();
    final results = appointmentCards.where((element) {
      final lowercasePatientId = element.patient.id.toLowerCase();
      final lowercasePatientFullName = element.patient.fullName.toLowerCase();
      final lowercasePatientAddress = element.patient.address.toLowerCase();
      final lowercasePatientDateOfBirth = element.patient.dateOfBirth != null
          ? element.patient.dateOfBirth.toString().toLowerCase()
          : "";
      final patientIdMatch = lowercasePatientId.contains(lowercaseQuery);
      final patientFullNameMatch = lowercasePatientFullName.contains(lowercaseQuery);
      final patientAddressMatch = lowercasePatientAddress.contains(lowercaseQuery);
      final patientDateOfBirthMatch = lowercasePatientDateOfBirth.contains(lowercaseQuery);
      final lowercaseGender = element.patient.gender == 0 ? "nam" : "nữ";
      final patientGenderMatch = lowercaseGender.contains(lowercaseQuery);

      final lowercaseAppointmentDateConfirmed = element.appointmentDateConfirmed != null ? element.appointmentDateConfirmed.toString().toLowerCase() : "";
      final appointmentDateConfirmedMatch = lowercaseAppointmentDateConfirmed.contains(lowercaseQuery);

      return patientIdMatch || patientFullNameMatch || patientAddressMatch || patientDateOfBirthMatch || patientGenderMatch || appointmentDateConfirmedMatch;
    }).toList();
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return AppointmentCardRegisteredItemCard(results[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final lowercaseQuery = query.toLowerCase();
    final suggestionList = appointmentCards.where((element) {
      final lowercasePatientId = element.patient.id.toLowerCase();
      final lowercasePatientFullName = element.patient.fullName.toLowerCase();
      final lowercasePatientAddress = element.patient.address.toLowerCase();
      final lowercasePatientDateOfBirth = element.patient.dateOfBirth != null
          ? element.patient.dateOfBirth.toString().toLowerCase()
          : "";
      final patientIdMatch = lowercasePatientId.contains(lowercaseQuery);
      final patientFullNameMatch = lowercasePatientFullName.contains(lowercaseQuery);
      final patientAddressMatch = lowercasePatientAddress.contains(lowercaseQuery);
      final patientDateOfBirthMatch = lowercasePatientDateOfBirth.contains(lowercaseQuery);
      final lowercaseGender = element.patient.gender == 0 ? "nam" : "nữ";
      final patientGenderMatch = lowercaseGender.contains(lowercaseQuery);

      final lowercaseAppointmentDateConfirmed = element.appointmentDateConfirmed != null ? element.appointmentDateConfirmed.toString().toLowerCase() : "";
      final appointmentDateConfirmedMatch = lowercaseAppointmentDateConfirmed.contains(lowercaseQuery);

      return patientIdMatch || patientFullNameMatch || patientAddressMatch || patientDateOfBirthMatch || patientGenderMatch || appointmentDateConfirmedMatch;
    }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return AppointmentCardRegisteredItemCard(suggestionList[index]);
        }
    );
  }
}