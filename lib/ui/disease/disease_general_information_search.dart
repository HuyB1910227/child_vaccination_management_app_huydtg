import 'package:flutter/material.dart';
import 'disease_general_information_search_page.dart';
import 'package:provider/provider.dart';
import './disease_general_information_manager.dart';
import '../../models/disease/disease_general_information.dart';
class DiseaseGeneralInformationSearch extends StatelessWidget {
  const DiseaseGeneralInformationSearch({super.key});

  @override
  Widget build(BuildContext context) {

    final diseases = context.select<DiseaseGeneralInformationManager, List<DiseaseGeneralInformation>>(
            (diseaseGeneralInformationManager) => diseaseGeneralInformationManager.diseases
    );

    return IconButton(
      icon: const Icon(Icons.search, size: 24),
      onPressed: () => showSearch(
        context: context,
        delegate: DiseaseInformationSearchDelegate(diseases),
      ),
    );
  }
}