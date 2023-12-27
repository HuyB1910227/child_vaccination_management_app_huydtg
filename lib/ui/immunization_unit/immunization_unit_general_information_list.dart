import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './immunization_unit_general_information_manager.dart';
import '../../models/immunization_unit/immunization_unit_general_information.dart';
import './immunization_unit_general_information_card.dart';
class ImmunizationUnitGeneralInformationList extends StatelessWidget {
  const ImmunizationUnitGeneralInformationList({super.key});

  @override
  Widget build(BuildContext context) {
    print("immunizationUnit screen");
    final immunizationUnits = context.select<ImmunizationUnitGeneralInformationManager, List<ImmunizationUnitGeneralInformation>>(
            (immunizationUnitGeneralInformationManager) => immunizationUnitGeneralInformationManager.immunizationUnits
    );
    print("yse");
    print(immunizationUnits);
    return ListView.builder(
      itemCount: immunizationUnits.length,
      itemBuilder: (context, index) => ImmunizationUnitGeneralInformationItemCard(immunizationUnits[index])
      ,
    );
  }
}