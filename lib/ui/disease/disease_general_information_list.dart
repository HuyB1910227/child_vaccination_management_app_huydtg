import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './disease_general_information_manager.dart';
import '../../models/disease/disease_general_information.dart';
import './disease_general_information_card.dart';
class DiseaseGeneralInformationList extends StatelessWidget {
  const DiseaseGeneralInformationList({super.key});

  @override
  Widget build(BuildContext context) {
    final diseases = context.select<DiseaseGeneralInformationManager, List<DiseaseGeneralInformation>>(
            (diseaseGeneralInformationManager) => diseaseGeneralInformationManager.diseases
    );

    return ListView.builder(
      itemCount: diseases.length,
      itemBuilder: (context, index) => DiseaseGeneralInformationItemCard(diseases[index])
     ,
    );
  }
}