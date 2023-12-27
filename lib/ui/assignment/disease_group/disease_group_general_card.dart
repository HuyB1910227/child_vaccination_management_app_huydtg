import 'package:flutter/material.dart';
import '../../screens.dart';
import 'package:provider/provider.dart';

import '../../../models/disease/disease_general_information.dart';
import '../assignment_detail/assignment_detail_screen.dart';

class DiseaseGroupGeneralItemCard extends StatefulWidget {
  final DiseaseGeneralInformation diseaseGeneralInformation;
  final int injectedTime;
  const DiseaseGroupGeneralItemCard(this.diseaseGeneralInformation, this.injectedTime, {super.key});

  @override
  State<DiseaseGroupGeneralItemCard> createState() => _DiseaseGroupGeneralItemCardState();
}

class _DiseaseGroupGeneralItemCardState extends State<DiseaseGroupGeneralItemCard> {


  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildDiseaseGroupGeneralSummary(),
        ],
      ),
    );
  }

  Widget buildDiseaseGroupGeneralSummary() {
    final List<int> assignmentIds = context.read<AssignmentManager>().getAssignmentIdsInDisease(widget.diseaseGeneralInformation.id);
    return
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
              AssignmentDetailScreen.routeName,
              arguments: assignmentIds,
          );
        },
        child: ListTile(
          title: Text(widget.diseaseGeneralInformation.name),
          trailing: CircleAvatar(
            backgroundColor: widget.injectedTime > 0 ? Colors.green : Colors.white,
            child: Text(
              '${widget.injectedTime > 0 ? widget.injectedTime : ''}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );

  }


}