import 'package:flutter/material.dart';
import 'notification_screen.dart';

class NotificationNavigateButton extends StatelessWidget {
  const NotificationNavigateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          NotificationScreen.routeName,
        );
      },
      icon: Icon(Icons.notifications, color: Colors.yellow,) ,
    );
  }
}
