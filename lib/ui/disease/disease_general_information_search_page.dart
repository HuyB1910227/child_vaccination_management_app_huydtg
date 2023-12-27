import 'package:flutter/material.dart';
import 'disease_general_information_card.dart';
import '../../models/disease/disease_general_information.dart';

class DiseaseInformationSearchDelegate extends SearchDelegate<String> {
  final List<DiseaseGeneralInformation> diseases;

  DiseaseInformationSearchDelegate(this.diseases);

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
    final results = diseases.where((element) {

      final lowercaseName = element.name.toLowerCase();

      final nameMatch = lowercaseName.contains(lowercaseQuery);
      return nameMatch;
    }).toList();
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return DiseaseGeneralInformationItemCard(results[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final lowercaseQuery = query.toLowerCase();
    final suggestionList = diseases.where((element) {
      final lowercaseName = element.name.toLowerCase();
      final nameMatch = lowercaseName.contains(lowercaseQuery);
      return nameMatch;
    }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return DiseaseGeneralInformationItemCard(suggestionList[index]);
        }
    );

  }}