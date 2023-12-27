import 'package:flutter/material.dart';
import 'vaccine_general_information_search_page.dart';
import 'package:provider/provider.dart';
import './vaccine_general_information_manager.dart';
import '../../models/vaccine/vaccine_general_information.dart';
import './vaccine_general_information_card.dart';

class VaccineGeneralInformationSearch extends StatelessWidget {
  const VaccineGeneralInformationSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final vaccines = context.select<VaccineGeneralInformationManager,
        List<VaccineGeneralInformation>>(
            (vaccineGeneralInformationManager) =>
        vaccineGeneralInformationManager.vaccines);

    return IconButton(
      icon: const Icon(Icons.search, size: 24),
      onPressed: () => showSearch(
        context: context,
        delegate: VaccineInformationSearchDelegate(vaccines),
      ),
    );
  }
}
