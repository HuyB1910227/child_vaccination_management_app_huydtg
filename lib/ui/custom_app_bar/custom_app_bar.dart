
import 'package:flutter/material.dart';
import '../../models/patient/patient_general_information.dart';
import '../patient/patient_general_information_manager.dart';
import 'package:provider/provider.dart';
import '../patient/patient_general_information_search_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onNotificationPressed;
  final String callSearchEngine;



  @override
  final Size preferredSize;

  CustomAppBar({
    required this.title,
    this.onNotificationPressed,
    required this.callSearchEngine,

    Key? key,
  }) : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        if (callSearchEngine == "patient")
          IconButton(
            onPressed: () {
              final patients = context.select<PatientGeneralInformationManager, List<PatientGeneralInformation>>(
                      (patientGeneralInformationManager) => patientGeneralInformationManager.patients
              );
              showSearch(
                context: context,
                delegate: PatientInformationSearchDelegate(patients),
              );
            },
            icon: const Icon(Icons.search, color: Colors.yellow),
          ),
          IconButton(
            onPressed: () {
              if (onNotificationPressed != null) {
                onNotificationPressed!();
              }
            },
            icon: const Icon(Icons.notifications, color: Colors.yellow),
          ),
      ],
    );
  }
}


