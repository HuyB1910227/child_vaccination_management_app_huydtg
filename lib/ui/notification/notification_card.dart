import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../../models/notification/notification.dart';

class NotificationItemCard extends StatefulWidget {
  final NotificationItem notification;
  const NotificationItemCard(this.notification, {super.key});

  @override
  State<NotificationItemCard> createState() => _NotificationItemCardState();
}

class _NotificationItemCardState extends State<NotificationItemCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateChip(
          date: new DateTime(widget.notification.sentDate.year, widget.notification.sentDate.month, widget.notification.sentDate.day),
        ),
        BubbleSpecialOne(
        text: widget.notification.message,
          isSender: false,
          color: Colors.orange.shade100,
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    );




  }
}