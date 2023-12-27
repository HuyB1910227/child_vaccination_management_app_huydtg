import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/notification/notification.dart';
import '../../models/auth_token.dart';
import '../api_service.dart';


class NotificationService extends ApiService {
  NotificationService([AuthToken? authToken]) : super (authToken);
  Future<List<NotificationItem>> getNotification() async {
    List<NotificationItem> listNotification = [];
    try {
      final url = Uri.parse('$defaultUrl/api/notifications/by-token');
      print(url);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken ?? ""}',
        },
      );
      if (response.statusCode != 200) {
        print("can not regis token");
        return [];
      }
      final responseDataString =
      utf8.decode(response.bodyBytes);
      final responseDataMap =
      json.decode(responseDataString);
      print(responseDataMap);
      if (responseDataMap.isEmpty) {
        return [];
      }
      try {
        responseDataMap.forEach((notification) {
          listNotification.add(NotificationItem.fromJson(notification));
        });
        print(listNotification);
        return listNotification;
      } catch (e) {
        print(e);
      }
      return listNotification;
    } catch (error) {
      return [];
    }
  }
}
