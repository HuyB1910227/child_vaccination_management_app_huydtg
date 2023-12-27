import 'package:flutter/material.dart';
import 'patient_general_information_search_page.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import './patient_general_information_manager.dart';
import '../../models/patient/patient_general_information.dart';
import './patient_general_information_card.dart';

class PatientGeneralInformationSearch extends StatelessWidget {
  const PatientGeneralInformationSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = context.select<PatientGeneralInformationManager,
            List<PatientGeneralInformation>>(
        (patientGeneralInformationManager) =>
            patientGeneralInformationManager.patients);

    return IconButton(
      icon: const Icon(Icons.search, size: 24),
      onPressed: () => showSearch(
        context: context,
        delegate: PatientInformationSearchDelegate(patients),
      ),
    );
  }
}
