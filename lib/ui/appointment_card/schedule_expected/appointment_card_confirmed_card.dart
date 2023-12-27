import 'package:flutter/material.dart';
import '../../../ui/screens.dart';
import 'package:intl/intl.dart';
import '../../../models/appointment_card/appointment_card.dart';

class AppointmentCardConfirmedItemCard extends StatefulWidget {
  final AppointmentCard appointmentCard;
  const AppointmentCardConfirmedItemCard(this.appointmentCard, {super.key});

  @override
  State<AppointmentCardConfirmedItemCard> createState() =>
      _AppointmentCardConfirmedItemCardState();
}

class _AppointmentCardConfirmedItemCardState
    extends State<AppointmentCardConfirmedItemCard> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final appointmentDate = widget.appointmentCard.appointmentDateConfirmed!;
    bool isToday = appointmentDate.year == now.year &&
        appointmentDate.month == now.month &&
        appointmentDate.day == now.day;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.appointmentCard.appointmentDateConfirmed != null)
                                Text(
                                  "Thời gian: ${DateFormat('HH giờ mm ').format(widget.appointmentCard.appointmentDateConfirmed!)}",
                                  style: const TextStyle(color: Colors.blueAccent),
                                ),
                              if (widget.appointmentCard.appointmentDateConfirmed != null)
                                Text(
                                  "Ngày: ${DateFormat('dd/MM/yyyy').format(widget.appointmentCard.appointmentDateConfirmed!)}",
                                  style: const TextStyle(color: Colors.blueAccent),
                                ),
                          ],
                        )
                      ),
                      if (isToday)
                        const Chip(
                          backgroundColor: Colors.blueAccent,
                          label: Text(
                            "Hôm nay",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      if(!isToday)
                        const Chip(
                          backgroundColor: Colors.orangeAccent,
                          label: Text(
                            "Sắp đến hạn",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                ),
                const Divider(),
                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Mã số: "),
                    ),
                    Expanded(child: Text(widget.appointmentCard.patient.id),),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Họ tên: "),
                    ),
                    Expanded(child: Text(widget.appointmentCard.patient.fullName),),
                  ],
                ),
                const SizedBox(height: 5,),

                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Địa chỉ: "),
                    ),
                    Expanded(child: Text("${widget.appointmentCard.patient.address}"),),
                  ],
                ),
                const SizedBox(height: 5,),

                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Giới tính "),
                    ),
                    Expanded(child: Text("${widget.appointmentCard.patient.gender == 1 ? 'Nữ' : "Nam"}"),),
                  ],
                ),
                const SizedBox(height: 5,),

                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Ngày sinh: "),
                    ),
                    Expanded(child: Text("${DateFormat('dd/MM/yyyy').format(widget.appointmentCard.patient.dateOfBirth)}"),),
                  ],
                ),

                // // Text("Mã số: ${widget.appointmentCard.patient.id}"),
                // Text("Họ và tên: ${widget.appointmentCard.patient.fullName}"),
                // Text("Địa chỉ: ${widget.appointmentCard.patient.address}"),
                // Text(
                //     "Giới tính: ${widget.appointmentCard.patient.gender == 1 ? 'Nữ' : "Nam"}"),
                // Text(
                //     "Ngày sinh: ${DateFormat('dd/MM/yyyy').format(widget.appointmentCard.patient.dateOfBirth)}"),
                const Divider(),
                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Cơ sở: "),
                    ),
                    Expanded(child: Text("${widget.appointmentCard.immunizationUnit.name}"),),
                  ],
                ),
                const SizedBox(height: 5,),

                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Địa chỉ: "),
                    ),
                    Expanded(child: Text("${widget.appointmentCard.immunizationUnit.address}"),),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Ghi chú: "),
                    ),
                    Expanded(child: Text("${widget.appointmentCard.note}"),),
                  ],
                ),
                const Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        AppointmentCardDetailScreen.routeName,
                        arguments: widget.appointmentCard.id);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    primary: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.purple),
                    ),
                  ),
                  child: Ink(
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        alignment: Alignment.center,
                        child: const Text("Xem chi tiết",
                            style: TextStyle(color: Colors.purpleAccent)),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
