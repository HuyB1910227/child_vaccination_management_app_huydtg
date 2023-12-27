
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'patient_detail_info_component.dart';
import '../patient_manager.dart';
import '../../../models/patient/patient.dart';
import '../../../ui/main_screen.dart';

class PatientDetailScreen extends StatelessWidget {
  static const routeName = '/patient-detail';
  final String patientId;
  const PatientDetailScreen(this.patientId, {super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(
            title: Text("Thông tin trẻ em"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen(defaultSelectedIndex: 0)));
              },
            ),
          ),
          body: FutureBuilder(
              future: context.read<PatientManager>().fetchPatient(patientId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    final patient = snapshot.data as Patient;
                    return Container(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              child: PatientDetailInfo(patient: patient));
                  }
                  else {
                    return const Center(child: Text("Không tìm thấy thông tin chi tiết của trẻ!"));
                  }

                }
                return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
