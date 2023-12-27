import 'package:flutter/material.dart';
import '../../../models/appointment_card/appointment_prepare.dart';
import '../../../models/fixed_schedule/working_calendar.dart';
import '../../appointment_card/registration_appointment_card_form_screen.dart';
import 'package:intl/intl.dart';
class EventCard extends StatelessWidget {
  final WorkingCalendar workingCalendar;
  final String immunizationUnitId;
  const EventCard({required this.workingCalendar, required this.immunizationUnitId, super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentPrepare = AppointmentPrepare(immunizationUnitId: immunizationUnitId, workingCalendar: workingCalendar);
    DateTime oneDayAgo = DateTime.now().subtract(Duration(days: 1));
    return Padding(
      padding: const EdgeInsets.all(10),
      child:
        Card(
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
                              Text(
                                "Ngày: ${DateFormat('dd/MM/yyyy').format(workingCalendar.date)}",
                                style: const TextStyle(color: Colors.blueAccent),
                              ),
                            ],
                          )
                      ),
                      if (!oneDayAgo.isAfter(workingCalendar.date))
                        IconButton(onPressed: () {
                          Navigator.of(context).pushNamed(
                            RegistrationAppointmentCardFormScreen.routeName,
                            arguments: appointmentPrepare,
                          );}, icon: const Icon(Icons.app_registration, color: Colors.purple,))

                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(child: Text(workingCalendar.title),),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text("Thời gian: "),
                      ),
                      Expanded(child: Text(
                        "Từ ${DateFormat('HH giờ mm ').format(workingCalendar.startTime)}đến ${DateFormat('HH giờ mm ').format(workingCalendar.endTime)} ",
                        style: const TextStyle(color: Colors.blueAccent),
                      ),),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text("Loại hình: "),
                      ),
                      Expanded(child: Text(
                        "${workingCalendar.vaccinationType == 'DICH_VU' ? 'TIÊM CHỦNG DỊCH VỤ' : 'TIÊM CHỦNG MỞ RỘNG'}",
                        style: const TextStyle(color: Colors.purple),
                      ),),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text("Ghi chú: "),
                      ),
                      Expanded(child: Text(workingCalendar.note ?? 'Không có ghi chú'),),
                    ],
                  ),
                ],
              ),
            )),


    );
  }
}
