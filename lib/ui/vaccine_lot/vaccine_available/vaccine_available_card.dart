import 'package:flutter/material.dart';
import '../../vaccine/vaccine_detail/vaccine_detail_screen.dart';

import '../../../models/vaccine_lot/vaccine_available.dart';

class VaccineAvailableInformationItemCard extends StatefulWidget {
  final VaccineAvailable vaccineAvailable;
  const VaccineAvailableInformationItemCard(this.vaccineAvailable, {super.key});

  @override
  State<VaccineAvailableInformationItemCard> createState() =>
      _VaccineAvailableInformationItemCardState();
}

class _VaccineAvailableInformationItemCardState
    extends State<VaccineAvailableInformationItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildVaccineAvailableInformationSummary(),
        ],
      ),
    );
  }

  Widget buildVaccineAvailableInformationSummary() {
    return ListTile(
      leading: Card(
        color: widget.vaccineAvailable.vaccinationType == 'DICH_VU'? Colors.blueAccent : Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
              widget.vaccineAvailable.vaccinationType == 'DICH_VU'
              ? 'Dịch vụ'
              : 'Mở rộng',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      title: Text(widget.vaccineAvailable.name),
      subtitle: Text("Mã số: ${widget.vaccineAvailable.id}"),
      trailing: IconButton(
        icon: const Icon(Icons.navigate_next),
        onPressed: () {
          Navigator.of(context).pushNamed(VaccineDetailScreen.routeName,
              arguments: widget.vaccineAvailable.id);
          print("go to immunizationUnit detail");
        },
        color: Colors.purple,
      ),
    );
  }
}
