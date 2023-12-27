import 'package:flutter/material.dart';
import '../screens.dart';
import '../../models/vaccine/vaccine_general_information.dart';

class VaccineGeneralInformationItemCard extends StatefulWidget {
  final VaccineGeneralInformation vaccineGeneralInformation;
  const VaccineGeneralInformationItemCard(this.vaccineGeneralInformation, {super.key});

  @override
  State<VaccineGeneralInformationItemCard> createState() => _VaccineGeneralInformationItemCardState();
}

class _VaccineGeneralInformationItemCardState extends State<VaccineGeneralInformationItemCard> {


  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildVaccineGeneralInformationSummary(),
        ],
      ),
    );
  }

  Widget buildVaccineGeneralInformationSummary() {
    return ListTile(

      title: Text(widget.vaccineGeneralInformation.name),
      subtitle: Text("Mã vắc xin: ${widget.vaccineGeneralInformation.id}" ),
      trailing: IconButton(
        icon: const Icon(Icons.navigate_next),
        onPressed: () {
          Navigator.of(context).pushNamed(
              VaccineDetailScreen.routeName,
              arguments: widget.vaccineGeneralInformation.id
          );
          print("go to vaccine detail");
        },
        color: Colors.purple,
      ),
    );
  }


}