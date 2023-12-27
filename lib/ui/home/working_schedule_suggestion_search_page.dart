import 'package:flutter/material.dart';
import 'working_schedule_suggestion_card.dart';
import '../../models/fixed_schedule/fixed_schedule.dart';

class WorkingScheduleSuggestionSearchDelegate extends SearchDelegate<String> {
  final List<FixedSchedule> fixedSchedules;

  WorkingScheduleSuggestionSearchDelegate(this.fixedSchedules);

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
    final results = fixedSchedules.where((element) {
      final lowercaseImmunizationUnitId = element.immunizationUnit.id.toLowerCase();
      final lowercaseImmunizationUnitName = element.immunizationUnit.name.toLowerCase();
      final lowercaseImmunizationAddress = element.immunizationUnit.address.toLowerCase();
      final lowercaseNote = element.note != null ? element.note!.toLowerCase() : "";
      final lowercaseStartTime = element.startTime != null
          ? element.startTime.toString().toLowerCase()
          : "";
      final lowercaseEndTime = element.endTime != null
          ? element.endTime.toString().toLowerCase()
          : "";
      final immunizationUnitIdMatch = lowercaseImmunizationUnitId.contains(lowercaseQuery);
      final immunizationUnitNameMatch = lowercaseImmunizationUnitName.contains(lowercaseQuery);
      final immunizationUnitAddressMatch = lowercaseImmunizationAddress.contains(lowercaseQuery);
      final note = lowercaseNote.contains(lowercaseQuery);
      final startTime = lowercaseStartTime.contains(lowercaseQuery);
      final endTime = lowercaseEndTime.contains(lowercaseQuery);
      return immunizationUnitIdMatch || immunizationUnitNameMatch || immunizationUnitAddressMatch || note || startTime || endTime;
    }).toList();
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return WorkingScheduleSuggestionCard(fixedSchedule: results[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final lowercaseQuery = query.toLowerCase();
    final suggestionList = fixedSchedules.where((element) {
      final lowercaseImmunizationUnitId = element.immunizationUnit.id.toLowerCase();
      final lowercaseImmunizationUnitName = element.immunizationUnit.name.toLowerCase();
      final lowercaseImmunizationAddress = element.immunizationUnit.address.toLowerCase();
      final lowercaseNote = element.note != null ? element.note!.toLowerCase() : "";
      final lowercaseStartTime = element.startTime != null
          ? element.startTime.toString().toLowerCase()
          : "";
      final lowercaseEndTime = element.endTime != null
          ? element.endTime.toString().toLowerCase()
          : "";
      final immunizationUnitIdMatch = lowercaseImmunizationUnitId.contains(lowercaseQuery);
      final immunizationUnitNameMatch = lowercaseImmunizationUnitName.contains(lowercaseQuery);
      final immunizationUnitAddressMatch = lowercaseImmunizationAddress.contains(lowercaseQuery);
      final note = lowercaseNote.contains(lowercaseQuery);
      final startTime = lowercaseStartTime.contains(lowercaseQuery);
      final endTime = lowercaseEndTime.contains(lowercaseQuery);
      return immunizationUnitIdMatch || immunizationUnitNameMatch || immunizationUnitAddressMatch || note || startTime || endTime;
    }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return WorkingScheduleSuggestionCard(fixedSchedule: suggestionList[index]);
        }
    );
  }
}