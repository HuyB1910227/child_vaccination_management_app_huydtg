import 'history_general_information_search.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'history_general_information_list.dart';
import 'history_manager.dart';

class HistoryGeneralInformationScreen extends StatefulWidget {
  static const routeName = '/histories';
  const HistoryGeneralInformationScreen({super.key});

  @override
  State<HistoryGeneralInformationScreen> createState() => _HistoryGeneralInformationScreenState();
}

class _HistoryGeneralInformationScreenState extends State<HistoryGeneralInformationScreen> {

  late Future<void> _fetchHistoryGeneralInformation;

  @override
  void initState() {
    super.initState();
    _fetchHistoryGeneralInformation = context.read<HistoryManager>().fetchAllHistoryForCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _fetchHistoryGeneralInformation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Lịch sử tiêm chủng"),
              actions: const [HistoryGeneralInformationSearch()],
            ),
            body: HistoryGeneralInformationList(),
          );
        }
        return
          Scaffold(
            appBar: AppBar(
              title: const Text("Lịch sử tiêm chủng"),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            )
          );
      },
    );

  }
}