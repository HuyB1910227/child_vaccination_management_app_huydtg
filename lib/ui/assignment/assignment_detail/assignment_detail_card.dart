import 'package:flutter/material.dart';
import '../../../models/assignment/assignment.dart';
import 'package:intl/intl.dart';
class AssignmentItemCard extends StatefulWidget {
  final Assignment assignment;
  final int injectedTime;
  const AssignmentItemCard(this.assignment, this.injectedTime,
      {super.key});

  @override
  State<AssignmentItemCard> createState() =>
      _AssignmentItemCardState();
}

class _AssignmentItemCardState
    extends State<AssignmentItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildAssignmentMeasurementDate (),
          if (_expanded) buildOtherInfo(),
        ],
      ),
    );
  }

  Widget buildAssignmentMeasurementDate() {
    return ListTile(
      title: Text('Lần ${widget.injectedTime}'),
      trailing: IconButton(
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        color: Colors.purple,
      ),
    );
  }

  Widget buildOtherInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            if (widget.assignment.injectionCompletionTime != null)
              Row(
                children: [
                  const SizedBox(
                    width: 100.0,
                    child: Text("Thời gian tiêm: "),
                  ),
                  Expanded(child: Text("${DateFormat('dd/MM/yyyy').format(widget.assignment.injectionCompletionTime!)}")),
                ],
              ),

            if (widget.assignment.injectionCompletionTime == null)
              const Row(
                children: [
                  SizedBox(
                    width: 100.0,
                    child: Text("Thời gian tiêm: "),
                  ),
                  Expanded(child: Text("Không có thông tin")),
                ],
              ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                  width: 100.0,
                  child: Text("Vị trí tiêm: "),
                ),
                Expanded(child: Text("${widget.assignment.route}")),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                  width: 100.0,
                  child: Text("Tên vắc xin: "),
                ),
                Expanded(child: Text(widget.assignment.vaccineLot.vaccine.name)),
              ],
            ),

            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                  width: 100.0,
                  child: Text("Mã số lô: "),
                ),
                Expanded(child: Text(widget.assignment.vaccineLot.lotCode)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                  width: 100.0,
                  child: Text("Hình thức: "),
                ),
                Expanded(child: Text(widget.assignment.vaccineLot.vaccinationType == 'DICH_VU' ? 'TIÊM CHỦNG DỊCH VỤ' : 'TIÊM CHỦNG MỞ RỘNG')),
              ],
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
