import 'package:flutter/material.dart';
import '../auth/auth_manager.dart';
import '../auth/auth_screen.dart';
import '../immunization_unit/immunization_unit_detail/immunization_unit_detail_screen.dart';
import 'package:provider/provider.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              )),
        ],
      ));
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xuất hiện 1 lỗi'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Đã hiểu'),
          ),
        ],
      ));
}

Future<void> showLogoutLocalDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Yêu cầu đăng nhập lại'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              ctx.read<AuthManager>().logoutLocal();
              Navigator.of(context).popUntil((route) => route.isFirst);

            },
            child: const Text('Tiếp tục'),
          ),
        ],
      ));
}

Future<void> showLogoutDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Yêu cầu đăng nhập lại'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              ctx.read<AuthManager>().logout();
              Navigator.of(context).popUntil((route) => route.isFirst);

            },
            child: const Text('Tiếp tục'),
          ),
        ],
      ));
}

Future<void> showSuccessRegistrationFormDialog(BuildContext context, String message, String immunizationUnitId) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Đăng ký thành công'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Navigator.of(ctx).pop();
              Navigator.of(context).pushReplacementNamed(
                ImmunizationUnitDetailScreen.routeName,
                arguments: immunizationUnitId,
              );
            },
            child: const Text('Đã hiểu'),
          ),
        ],
      ));
}
