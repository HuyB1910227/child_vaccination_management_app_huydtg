import '../notification/notification_screen.dart';
import 'patient_general_information_search.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../notification/notification_navigate_button.dart';


import 'patient_general_information_manager.dart';
import 'patient_general_information_list.dart';

class PatientGeneralInformationScreen extends StatefulWidget {
  static const routeName = '/patients';
  const PatientGeneralInformationScreen({super.key});

  @override
  State<PatientGeneralInformationScreen> createState() => _PatientGeneralInformationScreenState();
}

class _PatientGeneralInformationScreenState extends State<PatientGeneralInformationScreen> {
  late Future<void> _fetchPatientGeneralInformation;

  @override
  void initState() {
    super.initState();
    _fetchPatientGeneralInformation = context.read<PatientGeneralInformationManager>().fetchPatientGeneralInformation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchPatientGeneralInformation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Thành viên"),
                actions: const <Widget>[
                  PatientGeneralInformationSearch(),
                  NotificationNavigateButton(),
                ],
              ),
              body: const PatientGeneralInformationList(),
            );
          }
          return
          Scaffold(
            appBar: AppBar(
              title: const Text("Thành viên"),
              actions: const <Widget>[
                NotificationNavigateButton(),
              ],
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );


    }

  // Widget buildRingIcon() {
  //   return
  // }
}
