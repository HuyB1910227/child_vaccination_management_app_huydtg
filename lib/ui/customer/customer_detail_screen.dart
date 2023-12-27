
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'customer_detail_info_component.dart';
import 'customer_manager.dart';
import '../../models/customer/customer.dart';
import '../notification/notification_navigate_button.dart';
class CustomerDetailScreen extends StatelessWidget {
  static const routeName = '/customer-detail';
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: context.read<CustomerManager>().fetchCustomerDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                final customer = snapshot.data as Customer;
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Thông tin cá nhân"),
                    actions: const [NotificationNavigateButton()],
                  ),
                  body: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: CustomerDetailInfo(customer: customer),
                  ),
                );
              }
              else {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Thông tin cá nhân"),
                    actions: const [NotificationNavigateButton()],
                  ),
                  body: const Center(child: Text("Opss! Đã có lỗi xảy ra, quý khách vui lòng thử lại sau.")),
                );
              }
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text("Thông tin cá nhân"),
                actions: const [NotificationNavigateButton()],
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          });
  }
}
