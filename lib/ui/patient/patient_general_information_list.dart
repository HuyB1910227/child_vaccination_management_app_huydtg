import 'package:flutter/material.dart';
import 'patient_general_information_search_page.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import './patient_general_information_manager.dart';
import '../../models/patient/patient_general_information.dart';
import './patient_general_information_card.dart';

class PatientGeneralInformationList extends StatelessWidget {
  const PatientGeneralInformationList({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = context.select<PatientGeneralInformationManager,
            List<PatientGeneralInformation>>(
        (patientGeneralInformationManager) =>
            patientGeneralInformationManager.patients);

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) => PatientGeneralInformationItemCard(patients[index]),
    );
  }
}
