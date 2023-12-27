class NotificationItem {
  final String title;
  final String topic;
  final String message;
  final DateTime sentDate;


  NotificationItem({
    required this.title,
    required this.topic,
    required this.message,
    required this.sentDate,
  });

  NotificationItem copyWith({
    String? title,
    String? topic,
    String? message,
    DateTime? sentDate,
  }) {
    return NotificationItem(
      title: title ?? this.title,
      topic: topic ?? this.topic,
      message: message ?? this.message,
      sentDate: sentDate ?? this.sentDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'topic': topic,
      'message': message,
      'sentDate': sentDate.toIso8601String(),
    };
  }

  static NotificationItem fromJson(Map<dynamic, dynamic> json) {

      return NotificationItem(
        title: json['title'],
        topic: json['topic'],
        message: json['message'],
        sentDate: DateTime.parse(json['sentDate']),
      );


  }
}