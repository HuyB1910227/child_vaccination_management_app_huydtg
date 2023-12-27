import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'vaccine_general_information_manager.dart';
import 'vaccine_general_information_list.dart';
import 'vaccine_general_information_search.dart';
class VaccineGeneralInformationScreen extends StatefulWidget {
  static const routeName = '/vaccines';
  const VaccineGeneralInformationScreen({super.key});

  @override
  State<VaccineGeneralInformationScreen> createState() => _VaccineGeneralInformationScreenState();
}

class _VaccineGeneralInformationScreenState extends State<VaccineGeneralInformationScreen> {

  late Future<void> _fetchVaccineGeneralInformation;

  @override
  void initState() {
    super.initState();
    _fetchVaccineGeneralInformation = context.read<VaccineGeneralInformationManager>().fetchVaccineGeneralInformation();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _fetchVaccineGeneralInformation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Tra cứu vắc xin"),
              actions: const [VaccineGeneralInformationSearch()],
            ),
            body: const VaccineGeneralInformationList(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tra cứu vắc xin"),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          )
        );
      },
    );
  }
}