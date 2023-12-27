import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'history_manager.dart';
import '../../models/history/history_general_information.dart';
import 'history_general_information_card.dart';
class HistoryGeneralInformationList extends StatelessWidget {
  const HistoryGeneralInformationList({super.key});

  @override
  Widget build(BuildContext context) {

    final historyGeneralInformations = context.select<HistoryManager, List<HistoryGeneralInformation>>(
            (diseaseGeneralInformationManager) => diseaseGeneralInformationManager.historyGeneralInformations
    );

    return ListView.builder(
      itemCount: historyGeneralInformations.length,
      itemBuilder: (context, index) => HistoryGeneralInformationItemCard(historyGeneralInformations[index])
      ,
    );
  }
}