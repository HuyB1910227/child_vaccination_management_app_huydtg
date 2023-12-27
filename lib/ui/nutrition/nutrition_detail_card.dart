


import 'package:flutter/material.dart';

import '../../models/nutrition/nutrition.dart';
import 'package:intl/intl.dart';
class NutritionItemCard extends StatefulWidget {
  final Nutrition nutrition;
  const NutritionItemCard(this.nutrition,
      {super.key});

  @override
  State<NutritionItemCard> createState() =>
      _NutritionItemCardState();
}

class _NutritionItemCardState
    extends State<NutritionItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildNutritionMeasurementDate (),
          if (_expanded) buildOtherInfo(),
        ],
      ),
    );
  }

  Widget buildNutritionMeasurementDate() {
    return ListTile(
      title: Text('Ngày đo: ${DateFormat('dd/MM/yyyy').format(widget.nutrition.measurementDate)}'),
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
                Ink(
                  width: double.infinity,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Chiều cao')),
                      DataColumn(label: Text('Cân nặng')),
                    ],
                    rows: <DataRow>[
                      DataRow(cells: <DataCell>[
                        DataCell(Text('${widget.nutrition.height} m')),
                        DataCell(Text('${widget.nutrition.weight} kg')),
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Text("Chuẩn đoán tình trạng: ${widget.nutrition.status == null ||  widget.nutrition.status == ''? "Chưa có thông tin" : widget.nutrition.status}"),
              ],
            ),
          ),
    );
  }
}
