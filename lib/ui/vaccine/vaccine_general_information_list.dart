import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './vaccine_general_information_manager.dart';
import '../../models/vaccine/vaccine_general_information.dart';
import './vaccine_general_information_card.dart';

class VaccineGeneralInformationList extends StatelessWidget {
  const VaccineGeneralInformationList({super.key});

  @override
  Widget build(BuildContext context) {
    final vaccines = context.select<VaccineGeneralInformationManager,
            List<VaccineGeneralInformation>>(
        (vaccineGeneralInformationManager) =>
            vaccineGeneralInformationManager.vaccines);

    return ListView.builder(
      itemCount: vaccines.length,
      itemBuilder: (context, index) =>
          VaccineGeneralInformationItemCard(vaccines[index]),
    );
  }
}
