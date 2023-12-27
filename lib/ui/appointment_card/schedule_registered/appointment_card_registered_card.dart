import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/appointment_card/appointment_card.dart';

class AppointmentCardRegisteredItemCard extends StatefulWidget {
  final AppointmentCard appointmentCard;
  const AppointmentCardRegisteredItemCard(this.appointmentCard, {super.key});

  @override
  State<AppointmentCardRegisteredItemCard> createState() =>
      _AppointmentCardRegisteredItemCardState();
}

class _AppointmentCardRegisteredItemCardState
    extends State<AppointmentCardRegisteredItemCard> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Expanded(
                        child: Text("Thông tin đăng ký"),
                    ),

                      Chip(
                        backgroundColor: Colors.green,
                        label: Text(
                          "Chờ xác nhận",
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
                    Expanded(child: Text("${widget.appointmentCard.patient.fullName}"),),
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
                      child: Text("Ngày hẹn (theo yêu cầu): "),
                    ),
                    Expanded(child: Text("${DateFormat('HH giờ mm').format(widget.appointmentCard.appointmentDate!)} ${DateFormat('dd/MM/yyyy').format(widget.appointmentCard.appointmentDate!)}",
                      style: const TextStyle(color: Colors.blueAccent),
                    ),),
                  ],
                ),

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

              ],
            ),
          )),
    );
  }
}
