
import '../../../models/disease/disease_general_information.dart';
import '../../../models/assignment/assignment_for_diary.dart';
import '../../disease/disease_general_information_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'disease_group_general_card.dart';
import '../assignment_manager.dart';

class DiseaseGroupGeneralScreen extends StatefulWidget {
  static const routeName = '/disease-group-diary';
  final String patientId;
  const DiseaseGroupGeneralScreen(this.patientId, {super.key});

  @override
  State<DiseaseGroupGeneralScreen> createState() => _DiseaseGroupGeneralScreenState();
}

class _DiseaseGroupGeneralScreenState extends State<DiseaseGroupGeneralScreen> {

  late Future<void> _fetchDiseaseGroupGeneral;

  @override
  void initState() {
    super.initState();
    _fetchDiseaseGroupGeneral = context.read<DiseaseGeneralInformationManager>().fetchDiseaseGeneralInformation();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: context.read<AssignmentManager>().fetchAssignmentForDiaryByPatientId(widget.patientId),
      builder: (context, snapshot) {
        print("diary screen");
        if (snapshot.connectionState == ConnectionState.done) {
          final assignmentForDiary = snapshot.data as List<AssignmentForDiary>;
          return FutureBuilder(
              future: _fetchDiseaseGroupGeneral,
              builder: (context, snapshot) {
                print("disease group screen");
                if (snapshot.connectionState == ConnectionState.done) {
                  final diseases = context.select<DiseaseGeneralInformationManager, List<DiseaseGeneralInformation>>(
                          (diseaseGeneralInformationManager) => diseaseGeneralInformationManager.diseases
                  );
                  return Scaffold(
                    appBar: AppBar(title: const Text("Nhật ký tiêm chủng"),),
                    body: ListView.builder(
                        itemCount: diseases.length,
                        itemBuilder: (context, index) => DiseaseGroupGeneralItemCard(diseases[index], context.read<AssignmentManager>().countAssignmentInDiseaseGroup(diseases[index])))
                  );
                }
                return Scaffold(
                  appBar: AppBar(title: const Text("Nhật ký tiêm chủng"),),
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              });
        }
        return Scaffold(
          appBar: AppBar(title: Text("Nhật ký tiêm chủng"),),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
          
      },
    );

  }
}