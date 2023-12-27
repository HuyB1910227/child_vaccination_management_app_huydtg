import 'package:flutter/material.dart';
import 'history_general_information_search_page.dart';
import 'package:provider/provider.dart';
import 'history_manager.dart';
import '../../models/history/history_general_information.dart';
import 'history_general_information_card.dart';
class HistoryGeneralInformationSearch extends StatelessWidget {
  const HistoryGeneralInformationSearch({super.key});

  @override
  Widget build(BuildContext context) {

    final historyGeneralInformations = context.select<HistoryManager, List<HistoryGeneralInformation>>(
            (diseaseGeneralInformationManager) => diseaseGeneralInformationManager.historyGeneralInformations
    );

    return IconButton(
      icon: const Icon(Icons.search, size: 24),
      onPressed: () => showSearch(
        context: context,
        delegate: HistoryGeneralInformationSearchDelegate(historyGeneralInformations),
      ),
    );
  }
}