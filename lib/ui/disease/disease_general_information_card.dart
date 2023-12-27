import 'package:flutter/material.dart';
import './disease_detail/disease_detail_screen.dart';
import '../../models/disease/disease_general_information.dart';

class DiseaseGeneralInformationItemCard extends StatefulWidget {
  final DiseaseGeneralInformation diseaseGeneralInformation;
  const DiseaseGeneralInformationItemCard(this.diseaseGeneralInformation, {super.key});

  @override
  State<DiseaseGeneralInformationItemCard> createState() => _DiseaseGeneralInformationItemCardState();
}

class _DiseaseGeneralInformationItemCardState extends State<DiseaseGeneralInformationItemCard> {


  @override
  Widget build(BuildContext context) {
   
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildDiseaseGeneralInformationSummary(),
        ],
      ),
    );
  }

  Widget buildDiseaseGeneralInformationSummary() {
    return ListTile(
     
      title: Text(widget.diseaseGeneralInformation.name),


      trailing: IconButton(
        icon: const Icon(Icons.navigate_next),
        onPressed: () {
          Navigator.of(context).pushNamed(
            DiseaseDetailScreen.routeName,
            arguments: widget.diseaseGeneralInformation.id
          );
          print("go to disease detail");
        },
        color: Colors.purple,
      ),
    );
  }

  
}