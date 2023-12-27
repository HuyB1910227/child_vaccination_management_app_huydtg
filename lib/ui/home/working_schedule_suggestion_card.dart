import 'package:flutter/material.dart';
import '../screens.dart';
import 'package:intl/intl.dart';
import '../../models/fixed_schedule/fixed_schedule.dart';

class WorkingScheduleSuggestionCard extends StatelessWidget {
  final FixedSchedule fixedSchedule;

  const WorkingScheduleSuggestionCard({required this.fixedSchedule, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay startTime = TimeOfDay.fromDateTime(fixedSchedule.startTime);
    TimeOfDay endTime = TimeOfDay.fromDateTime(fixedSchedule.endTime);
    bool isAfterStart = now.hour > startTime.hour ||
        (now.hour == startTime.hour && now.minute >= startTime.minute);

    bool isBeforeEnd = now.hour < endTime.hour ||
        (now.hour == endTime.hour && now.minute <= endTime.minute);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ImmunizationUnitDetailScreen.routeName, arguments: fixedSchedule.immunizationUnit.id);
        },
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.purpleAccent, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(fixedSchedule.immunizationUnit.name, style: const TextStyle(color: Colors.purpleAccent),),
                            ],
                          )),

                      if (isAfterStart && isBeforeEnd)
                        const Chip(
                          backgroundColor: Colors.blueAccent,
                          label: Text(
                            "Đang làm việc",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      else if (isAfterStart)
                        const Chip(
                          backgroundColor: Colors.redAccent,
                          label: Text(
                            "Ngừng làm việc",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      else if (isBeforeEnd)
                          const Chip(
                            backgroundColor: Colors.orangeAccent,
                            label: Text(
                              "Sắp làm việc",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text("Thời gian: "),
                      ),
                      Expanded(
                        child: Text(
                          "Từ ${DateFormat('HH giờ mm ').format(fixedSchedule.startTime)} đến ${DateFormat('HH giờ mm ').format(fixedSchedule.endTime)}",
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (fixedSchedule.note != null)
                    Row(
                      children: [
                        const SizedBox(
                          width: 100.0,
                          child: Text("Ghi chú: "),
                        ),
                        Expanded(
                          child: Text(fixedSchedule.note ?? 'Không có ghi chú'),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text("Địa chỉ: "),
                      ),
                      Expanded(
                        child: Text(fixedSchedule.immunizationUnit.address),
                      ),
                    ],
                  ),
                  // Text("${fixedSchedule.startTime}"),
                  // Text("${now}"),
                ],
              ),
            )),
      )




    );
  }
}
