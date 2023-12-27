import 'package:flutter/material.dart';
import 'working_schedule_suggestion_search_page.dart';

import '../../models/fixed_schedule/fixed_schedule.dart';

class WorkingScheduleSuggestionSearch extends StatelessWidget {
  final List<FixedSchedule>? fixedSchedules;
  const WorkingScheduleSuggestionSearch(this.fixedSchedules, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search, size: 24),
      onPressed: () => showSearch(
        context: context,
        delegate: WorkingScheduleSuggestionSearchDelegate(fixedSchedules??[]),
      ),
    );
  }
}