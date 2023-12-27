import 'package:flutter/material.dart';
import 'appointment_card_registered_search_page.dart';
import '../../../models/appointment_card/appointment_card.dart';
class AppointmentCardRegisteredSearch extends StatelessWidget {
  final List<AppointmentCard> appointmentCardConfirmedList;
  const AppointmentCardRegisteredSearch(this.appointmentCardConfirmedList, {super.key});

  @override
  Widget build(BuildContext context) {
    if (appointmentCardConfirmedList.isEmpty) {
      return const Icon(Icons.search, size: 24);
    }
    return ElevatedButton(
      onPressed: () => showSearch(
        context: context,
        delegate: AppointmentCardRegisteredSearchDelegate(appointmentCardConfirmedList),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        primary: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.white54),
        ),
      ),
      child: Ink(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 4),
            alignment: Alignment.center,
            child: const Text("🔍 Tìm kiếm ...",
                style: TextStyle(color: Colors.purpleAccent)),
          )),
    );
  }
}