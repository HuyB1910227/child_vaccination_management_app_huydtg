import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/history/history_general_information.dart';
import './history_detail/history_detail_screen.dart';
class HistoryGeneralInformationItemCard extends StatefulWidget {
  final HistoryGeneralInformation historyGeneralInformation;
  const HistoryGeneralInformationItemCard(this.historyGeneralInformation,
      {super.key});

  @override
  State<HistoryGeneralInformationItemCard> createState() =>
      _HistoryGeneralInformationItemCardState();
}

class _HistoryGeneralInformationItemCardState
    extends State<HistoryGeneralInformationItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Ngày tiêm: "),
                    ),
                    Expanded(child: Text(DateFormat('dd/MM/yyyy').format(widget.historyGeneralInformation.vaccinationDate)),),
                  ],
                ),
                const Divider(),
                Center(child: Text("THÔNG TIN NGƯỜI TIÊM"),)
                ,
                SizedBox(height: 10,),
                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Mã số: "),
                    ),
                    Expanded(child: Text(widget.historyGeneralInformation.patientGeneralInformation.id)),
                  ],
                ),

                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Họ và tên: "),
                    ),
                    Expanded(child: Text(widget.historyGeneralInformation.patientGeneralInformation.fullName),),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Địa chỉ: "),
                    ),
                    Expanded(child: Text(widget.historyGeneralInformation.patientGeneralInformation.address),),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Giới tính: "),
                    ),
                    Expanded(child: Text("${widget.historyGeneralInformation.patientGeneralInformation.gender == 1 ? 'Nữ' : "Nam"}"),),
                  ],
                ),

                Row(
                  children: [
                    const SizedBox(
                      width: 100.0,
                      child: Text("Ngày sinh: "),
                    ),
                    Expanded(child: Text(DateFormat('dd/MM/yyyy').format(widget.historyGeneralInformation.patientGeneralInformation.dateOfBirth)),),
                  ],
                ),


                Divider(),

                Row(
                  children: [
                    const SizedBox(
                      width: 150.0,
                      child: Text("Trạng thái sau tiêm: "),
                    ),
                    Expanded(child: Text(widget.historyGeneralInformation.statusAfterInjection ?? "Chưa cập nhật"),),
                  ],
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      HistoryDetailScreen.routeName,
                      arguments: widget.historyGeneralInformation.id,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    primary: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.purple),
                    ),
                  ),
                  child: Ink(
                      width: double.infinity,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
