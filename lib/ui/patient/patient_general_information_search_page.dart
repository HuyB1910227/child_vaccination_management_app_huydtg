import 'package:flutter/material.dart';
import 'patient_general_information_card.dart';
import '../../models/patient/patient_general_information.dart';

class PatientInformationSearchDelegate extends SearchDelegate<String> {
  final List<PatientGeneralInformation> patients;
  
  PatientInformationSearchDelegate(this.patients);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () { query = ''; }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
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
    // TODO: implement buildResults
    final lowercaseQuery = query.toLowerCase();

    final results = patients.where((element) {
      final lowercaseFullName = element.fullName.toLowerCase();
      final lowercaseAddress = element.address.toLowerCase();
      final lowercaseDateOfBirth = element.dateOfBirth != null
          ? element.dateOfBirth.toString().toLowerCase()
          : "";

      final fullNameMatch = lowercaseFullName.contains(lowercaseQuery);
      final addressMatch = lowercaseAddress.contains(lowercaseQuery);
      final dateOfBirthMatch = lowercaseDateOfBirth.contains(lowercaseQuery);


      final lowercaseGender = element.gender == 0 ? "nam" : "nữ";
      final genderMatch = lowercaseGender.contains(lowercaseQuery);


      return fullNameMatch || addressMatch || dateOfBirthMatch || genderMatch;
    }).toList();
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return PatientGeneralInformationItemCard(results[index]);
        });
  }



  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final lowercaseQuery = query.toLowerCase();

    final suggestionList = patients.where((element) {
      final lowercaseFullName = element.fullName.toLowerCase();
      final lowercaseAddress = element.address.toLowerCase();
      final lowercaseDateOfBirth = element.dateOfBirth != null
          ? element.dateOfBirth.toString().toLowerCase()
          : "";

      final fullNameMatch = lowercaseFullName.contains(lowercaseQuery);
      final addressMatch = lowercaseAddress.contains(lowercaseQuery);
      final dateOfBirthMatch = lowercaseDateOfBirth.contains(lowercaseQuery);


      final lowercaseGender = element.gender == 0 ? "nam" : "nữ";
      final genderMatch = lowercaseGender.contains(lowercaseQuery);


      return fullNameMatch || addressMatch || dateOfBirthMatch || genderMatch;
    }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return PatientGeneralInformationItemCard(suggestionList[index]);
        }
    );
    
  }}