import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../models/notification/notification.dart';
import 'notification_manager.dart';
import 'notification_token_manager.dart';
import 'notification_card.dart';
import 'package:provider/provider.dart';
class NotificationScreen extends StatefulWidget {
  static const routeName = 'notifications';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {



  late final Future<void> _registration;
  late Future<void> _fetchAllNotification;
  String registrationId = "not found";

  Future<void> setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    if (token != null) {
      registrationId = token;
      _registration = context.read<NotificationTokenManager>().registration(token);
    }
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
    _fetchAllNotification = context.read<NotificationManager>().fetchAllNotification();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông báo"),
      ),
      body:

            FutureBuilder(
              future: _fetchAllNotification,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var listNotification = snapshot.data as List<NotificationItem>;

                    if (listNotification.isEmpty) {
                      return const Center(
                        child: Text("Chưa có thông báo nào!"),
                      );
                    }
                    listNotification = listNotification.reversed.toList();
                    return ListView.builder(
                            reverse: true,
                            itemCount: listNotification.length,
                            itemBuilder: (context, index) => NotificationItemCard(listNotification[index]),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            )

    );
  }
}
