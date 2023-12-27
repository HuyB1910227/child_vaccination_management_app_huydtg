import 'package:flutter/material.dart';
import 'history_general_information_card.dart';
import '../../models/history/history_general_information.dart';

class HistoryGeneralInformationSearchDelegate extends SearchDelegate<String> {
  final List<HistoryGeneralInformation> histories;

  HistoryGeneralInformationSearchDelegate(this.histories);

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
    final results = histories.where((element) {
      final lowercasePatientId = element.patientGeneralInformation.id.toLowerCase();
      final lowercasePatientFullName = element.patientGeneralInformation.fullName.toLowerCase();
      final lowercasePatientAddress = element.patientGeneralInformation.address.toLowerCase();
      final lowercasePatientDateOfBirth = element.patientGeneralInformation.dateOfBirth != null
          ? element.patientGeneralInformation.dateOfBirth.toString().toLowerCase()
          : "";
      final patientIdMatch = lowercasePatientId.contains(lowercaseQuery);
      final patientFullNameMatch = lowercasePatientFullName.contains(lowercaseQuery);
      final patientAddressMatch = lowercasePatientAddress.contains(lowercaseQuery);
      final patientDateOfBirthMatch = lowercasePatientDateOfBirth.contains(lowercaseQuery);
      final lowercaseGender = element.patientGeneralInformation.gender == 0 ? "nam" : "nữ";
      final patientGenderMatch = lowercaseGender.contains(lowercaseQuery);

      final lowercaseVaccinationDate = element.vaccinationDate != null ? element.patientGeneralInformation.dateOfBirth.toString().toLowerCase() : "";
      final vaccinationDateMatch = lowercaseVaccinationDate.contains(lowercaseQuery);

      return patientIdMatch || patientFullNameMatch || patientAddressMatch || patientDateOfBirthMatch || patientGenderMatch || vaccinationDateMatch;
    }).toList();
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return HistoryGeneralInformationItemCard(results[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final lowercaseQuery = query.toLowerCase();
    final suggestionList = histories.where((element) {
      final lowercasePatientId = element.patientGeneralInformation.id.toLowerCase();
      final lowercasePatientFullName = element.patientGeneralInformation.fullName.toLowerCase();
      final lowercasePatientAddress = element.patientGeneralInformation.address.toLowerCase();
      final lowercasePatientDateOfBirth = element.patientGeneralInformation.dateOfBirth != null
          ? element.patientGeneralInformation.dateOfBirth.toString().toLowerCase()
          : "";
      final patientIdMatch = lowercasePatientId.contains(lowercaseQuery);
      final patientFullNameMatch = lowercasePatientFullName.contains(lowercaseQuery);
      final patientAddressMatch = lowercasePatientAddress.contains(lowercaseQuery);
      final patientDateOfBirthMatch = lowercasePatientDateOfBirth.contains(lowercaseQuery);
      final lowercaseGender = element.patientGeneralInformation.gender == 0 ? "nam" : "nữ";
      final patientGenderMatch = lowercaseGender.contains(lowercaseQuery);
      final lowercaseVaccinationDate = element.vaccinationDate != null ? element.patientGeneralInformation.dateOfBirth.toString().toLowerCase() : "";
      final vaccinationDateMatch = lowercaseVaccinationDate.contains(lowercaseQuery);
      return patientIdMatch || patientFullNameMatch || patientAddressMatch || patientDateOfBirthMatch || patientGenderMatch || vaccinationDateMatch;
    }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return HistoryGeneralInformationItemCard(suggestionList[index]);
        }
    );
  }
}