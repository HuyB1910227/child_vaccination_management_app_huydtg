import 'package:flutter/material.dart';
import './immunization_unit_detail/immunization_unit_detail_screen.dart';

import '../../models/immunization_unit/immunization_unit_general_information.dart';

class ImmunizationUnitGeneralInformationItemCard extends StatefulWidget {
  final ImmunizationUnitGeneralInformation immunizationUnitGeneralInformation;
  const ImmunizationUnitGeneralInformationItemCard(this.immunizationUnitGeneralInformation, {super.key});

  @override
  State<ImmunizationUnitGeneralInformationItemCard> createState() => _ImmunizationUnitGeneralInformationItemCardState();
}

class _ImmunizationUnitGeneralInformationItemCardState extends State<ImmunizationUnitGeneralInformationItemCard> {


  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildImmunizationUnitGeneralInformationSummary(),
        ],
      ),
    );
  }

  Widget buildImmunizationUnitGeneralInformationSummary() {
    return ListTile(
      leading: Icon(Icons.circle, color: widget.immunizationUnitGeneralInformation.isActive == true ? Colors.green : Colors.red),
      title: Text(widget.immunizationUnitGeneralInformation.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${widget.immunizationUnitGeneralInformation.address}'),
        ],
      ),
      trailing:

          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.of(context).pushNamed(
                  ImmunizationUnitDetailScreen.routeName,
                  arguments: widget.immunizationUnitGeneralInformation.id
              );
              print("go to immunizationUnit detail");
            },
            color: Colors.purple,
          ),
    );
  }


}