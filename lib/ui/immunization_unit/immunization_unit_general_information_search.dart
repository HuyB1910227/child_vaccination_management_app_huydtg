import 'package:flutter/material.dart';
import 'immunization_unit_general_information_search_page.dart';
import 'package:provider/provider.dart';
import './immunization_unit_general_information_manager.dart';
import '../../models/immunization_unit/immunization_unit_general_information.dart';

class ImmunizationUnitGeneralInformationSearch extends StatelessWidget {
  const ImmunizationUnitGeneralInformationSearch({super.key});

  @override
  Widget build(BuildContext context) {

    final immunizationUnits = context.select<ImmunizationUnitGeneralInformationManager, List<ImmunizationUnitGeneralInformation>>(
            (immunizationUnitGeneralInformationManager) => immunizationUnitGeneralInformationManager.immunizationUnits
    );

    return IconButton(
      icon: const Icon(Icons.search, size: 24),
      onPressed: () => showSearch(
        context: context,
        delegate: ImmunizationUnitInformationSearchDelegate(immunizationUnits),
      ),
    );
  }
}