import '../../../models/appointment_card/appointment_card.dart';
import '../../notification/notification_navigate_button.dart';

import '../schedule_registered/appointment_card_registered_search.dart';
import 'appointment_card_confirmed_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../appointment_card_manager.dart';
import 'appointment_card_confirmed_search.dart';
import '../schedule_registered/appointment_card_registered_card.dart';

class AppointmentCardConfirmedScreen extends StatefulWidget {
  static const routeName = '/schedule-expected';
  const AppointmentCardConfirmedScreen({super.key});

  @override
  State<AppointmentCardConfirmedScreen> createState() =>
      _AppointmentCardConfirmedScreenState();
}

class _AppointmentCardConfirmedScreenState
    extends State<AppointmentCardConfirmedScreen> {
  late Future<List<AppointmentCard>> _fetchAppointmentCardConfirmed;
  late Future<List<AppointmentCard>> _fetchAppointmentCardRegistered;


  @override
  void initState() {
    super.initState();
    _fetchAppointmentCardConfirmed = context
        .read<AppointmentCardManager>()
        .fetchAppointmentCardToScheduleExpected();
    _fetchAppointmentCardRegistered = context.read<AppointmentCardManager>().fetchAppointmentCardToScheduleRegistered();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [NotificationNavigateButton()],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Đã xác nhận",
              ),
              Tab(text: "Đã đăng ký"),
            ],
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.white70,
          ),
          title: const Text('Lịch trình dự kiến'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: TabBarView(
            children: [
              FutureBuilder(
                future: _fetchAppointmentCardConfirmed,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final appointmentCardConfirmedList =
                    snapshot.data as List<AppointmentCard>;
                    if (appointmentCardConfirmedList.isEmpty) {
                      return const Center(
                        child: Text(
                            "Quý khách không có lịch hẹn tiêm trong từ trong 7 ngày tiếp theo. Để có thể tiêm chủng cho trẻ, quý khách vui lòng đăng ký tiêm tại các cơ sở tiêm chủng!"),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0), child: AppointmentCardConfirmedSearch(appointmentCardConfirmedList),),
                          Column(
                            children: appointmentCardConfirmedList
                                .map((e) => AppointmentCardConfirmedItemCard(e))
                                .toList(),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: _fetchAppointmentCardRegistered,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final appointmentCardRegisteredList =
                    snapshot.data as List<AppointmentCard>;
                    if (appointmentCardRegisteredList.isEmpty) {
                      return const Center(
                        child: Text(
                            "Quý khách chưa đăng ký lịch tiêm nào tính từ thời điểm hiện tại!"),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0), child: AppointmentCardRegisteredSearch(appointmentCardRegisteredList),),
                          Column(
                            children: appointmentCardRegisteredList
                                .map((e) => AppointmentCardRegisteredItemCard(e))
                                .toList(),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}
