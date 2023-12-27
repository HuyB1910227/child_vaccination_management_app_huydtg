import 'package:flutter/material.dart';
import 'vaccine_general_information_card.dart';
import '../../models/vaccine/vaccine_general_information.dart';

class VaccineInformationSearchDelegate extends SearchDelegate<String> {
  final List<VaccineGeneralInformation> vaccines;

  VaccineInformationSearchDelegate(this.vaccines);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () { query = ''; }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // throw UnimplementedError();
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
    final results = vaccines.where((element) {
      final lowercaseId = element.id.toLowerCase();
      final lowercaseName = element.name.toLowerCase();
      final idMatch = lowercaseId.contains(lowercaseQuery);
      final nameMatch = lowercaseName.contains(lowercaseQuery);
      return idMatch || nameMatch;
    }).toList();
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return VaccineGeneralInformationItemCard(results[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final lowercaseQuery = query.toLowerCase();
    final suggestionList = vaccines.where((element) {
      final lowercaseId = element.id.toLowerCase();
      final lowercaseName = element.name.toLowerCase();
      final idMatch = lowercaseId.contains(lowercaseQuery);
      final nameMatch = lowercaseName.contains(lowercaseQuery);
      return idMatch || nameMatch;
    }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return VaccineGeneralInformationItemCard(suggestionList[index]);
        }
    );

  }}