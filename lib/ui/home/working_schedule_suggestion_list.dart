import 'package:flutter/material.dart';
import 'working_schedule_suggestion_card.dart';
import 'package:provider/provider.dart';
import '../fixed_schedule/fixed_schedule_manager.dart';
import '../../models/fixed_schedule/fixed_schedule.dart';
import 'working_schedule_suggestion_search.dart';
class WorkingScheduleSuggestionList extends StatefulWidget {
  const WorkingScheduleSuggestionList({super.key});

  @override
  State<WorkingScheduleSuggestionList> createState() =>
      _WorkingScheduleSuggestionListState();
}

class _WorkingScheduleSuggestionListState
    extends State<WorkingScheduleSuggestionList> {
  late final Future<List<FixedSchedule>> _fetchFixedScheduleCurrently;

  @override
  void initState() {
    super.initState();
    _fetchFixedScheduleCurrently =
        context.read<FixedScheduleManager>().fetchFixedScheduleCurrently();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchFixedScheduleCurrently,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final fixedSchedules = snapshot.data;
            if (fixedSchedules!.isEmpty) {
              return const Center(
                child: Text("Không có cơ sở nào đang làm việc hôn nay!"),
              );
            }
            return Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "LỊCH LÀM VIỆC HÔM NAY",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    WorkingScheduleSuggestionSearch(fixedSchedules),
                  ],
                ),
                Column(
                    children: fixedSchedules.map((i) {
                  return WorkingScheduleSuggestionCard(fixedSchedule: i);
                }).toList()),
              ],
            );


          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
