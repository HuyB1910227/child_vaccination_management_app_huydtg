import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'disease_general_information_manager.dart';
import 'disease_general_information_list.dart';
import 'disease_general_information_search.dart';
class DiseaseGeneralInformationScreen extends StatefulWidget {
  static const routeName = '/diseases';
  const DiseaseGeneralInformationScreen({super.key});

  @override
  State<DiseaseGeneralInformationScreen> createState() => _DiseaseGeneralInformationScreenState();
}

class _DiseaseGeneralInformationScreenState extends State<DiseaseGeneralInformationScreen> {
  
  late Future<void> _fetchDiseaseGeneralInformation;

  @override
  void initState() {
    super.initState();
    _fetchDiseaseGeneralInformation = context.read<DiseaseGeneralInformationManager>().fetchDiseaseGeneralInformation();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: _fetchDiseaseGeneralInformation,
        builder: (context, snapshot) {
          print("disease screen");
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Tra cứu dịch bệnh"),
                actions: const [DiseaseGeneralInformationSearch()],
              ),
              body: const DiseaseGeneralInformationList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

  }
}