import 'package:flutter/material.dart';
import 'immunization_unit_general_information_card.dart';
import '../../models/immunization_unit/immunization_unit_general_information.dart';

class ImmunizationUnitInformationSearchDelegate extends SearchDelegate<String> {
  final List<ImmunizationUnitGeneralInformation> immunizationUnits;

  ImmunizationUnitInformationSearchDelegate(this.immunizationUnits);

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
    final results = immunizationUnits.where((element) {
      final lowercaseId = element.id.toLowerCase();
      final lowercaseName = element.name.toLowerCase();
      final lowercaseAddress = element.address.toLowerCase();
      final idMatch = lowercaseId.contains(lowercaseQuery);
      final nameMatch = lowercaseName.contains(lowercaseQuery);
      final addressMatch = lowercaseAddress.contains(lowercaseQuery);
      return idMatch || nameMatch || addressMatch;
    }).toList();
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return ImmunizationUnitGeneralInformationItemCard(results[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final lowercaseQuery = query.toLowerCase();
    final suggestionList = immunizationUnits.where((element) {
      final lowercaseId = element.id.toLowerCase();
      final lowercaseName = element.name.toLowerCase();
      final lowercaseAddress = element.address.toLowerCase();
      final idMatch = lowercaseId.contains(lowercaseQuery);
      final nameMatch = lowercaseName.contains(lowercaseQuery);
      final addressMatch = lowercaseAddress.contains(lowercaseQuery);
      return idMatch || nameMatch || addressMatch;
    }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ImmunizationUnitGeneralInformationItemCard(suggestionList[index]);
        }
    );
  }}