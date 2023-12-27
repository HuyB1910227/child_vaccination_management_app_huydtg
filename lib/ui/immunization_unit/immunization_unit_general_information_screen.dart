import 'immunization_unit_general_information_search.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'immunization_unit_general_information_manager.dart';
import 'immunization_unit_general_information_list.dart';

class ImmunizationUnitGeneralInformationScreen extends StatefulWidget {
  static const routeName = '/immunization-units';
  const ImmunizationUnitGeneralInformationScreen({super.key});

  @override
  State<ImmunizationUnitGeneralInformationScreen> createState() => _ImmunizationUnitGeneralInformationScreenState();
}

class _ImmunizationUnitGeneralInformationScreenState extends State<ImmunizationUnitGeneralInformationScreen> {

  late Future<void> _fetchImmunizationUnitGeneralInformation;

  @override
  void initState() {
    super.initState();
    _fetchImmunizationUnitGeneralInformation = context.read<ImmunizationUnitGeneralInformationManager>().fetchAllImmunizationGeneralInformation();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _fetchImmunizationUnitGeneralInformation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Tra cứu cơ sở"),
              actions: const [ImmunizationUnitGeneralInformationSearch()],
            ),
            body: const ImmunizationUnitGeneralInformationList(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tra cứu cơ sở"),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}