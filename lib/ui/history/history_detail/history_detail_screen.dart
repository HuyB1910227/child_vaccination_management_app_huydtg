import 'dart:io';
import 'package:flutter/rendering.dart';
import '../../../models/assignment/assignment.dart';
import 'package:intl/intl.dart';
import '../../../models/history/history.dart';
import '../history_manager.dart';
import '../../assignment/assignment_manager.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HistoryDetailScreen extends StatefulWidget {
  static const routeName = '/history-detail';
  final int id;
  const HistoryDetailScreen(this.id, {super.key});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  late Future<History?> _fetchHistoryDetail;

  @override
  void initState() {
    super.initState();
    _fetchHistoryDetail = context.read<HistoryManager>().fetchHistoryById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _fetchHistoryDetail,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final history = snapshot.data as History;
          if (history != null) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: "Thông tin chung",),
                      Tab(text: "Chi tiết mũi tiêm"),
                    ],
                    labelColor: Colors.yellow,
                    unselectedLabelColor: Colors.white70,
                  ),
                  title: const Text('Lịch sử tiêm chủng'),
                ),
                body:
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TabBarView(
                    children: [
                        ListView(
                          children: <Widget>[
                            Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text("THÔNG TIN TRẺ EM"),
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Mã số: "),
                                          ),
                                          Expanded(child: Text(history.patient.id),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Họ và tên: "),
                                          ),
                                          Expanded(child: Text(history.patient.fullName),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Giới tính: "),
                                          ),
                                          Expanded(child: Text(history.patient.gender == 1 ? "Nữ" : "Nam"),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Ngày sinh: "),
                                          ),
                                          Expanded(child: Text(DateFormat('dd/MM/yyyy').format(history.patient.dateOfBirth)),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Địa chỉ: "),
                                          ),
                                          Expanded(child: Text(history.patient.address),),
                                        ],
                                      ),

                                    ],
                                  ),
                                )
                            ),
                            Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text("THÔNG TIN BUỔI TIÊM"),
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Ngày tiêm: "),
                                          ),
                                          Expanded(child: Text(DateFormat('dd/MM/yyyy').format(history.vaccinationDate)),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Cơ sở tiêm: "),
                                          ),
                                          Expanded(child: Text(history.appointmentCard.immunizationUnit.name),),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Địa chỉ: "),
                                          ),
                                          Expanded(child: Text(history.appointmentCard.immunizationUnit.address),),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Đường dây nóng: "),
                                          ),
                                          Expanded(child: Text(history.appointmentCard.immunizationUnit.hotline),),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Mã phiếu tiêm: "),
                                          ),
                                          Expanded(child: Text("${history.appointmentCard.id}"),),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Trạng thái sau tiêm: "),
                                          ),
                                          Expanded(child: Text(history.statusAfterInjection ?? 'Chưa cập nhật'),),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text("BÁC SĨ CHỈ ĐỊNH"),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Mã nhân viên: "),
                                          ),
                                          Expanded(child: Text("${history.appointmentCard.employee?.employeeId}"),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Họ và tên: "),
                                          ),
                                          Expanded(child: Text("${history.appointmentCard.employee?.fullName}"),),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                        FutureBuilder(
                            future: context.read<AssignmentManager>().fetchAssignmentsByAppointmentCardId(history.appointmentCard.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                final assignments = snapshot.data as List<Assignment>;
                                return ListView.builder(
                                    itemCount: assignments.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                if (assignments[index].injectionCompletionTime != null)
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 100.0,
                                                        child: Text("Thời gian tiêm: "),
                                                      ),
                                                      Expanded(child: Text(DateFormat('HH:mm').format(assignments[index].injectionCompletionTime!)),),
                                                    ],
                                                  ),

                                                const SizedBox(height: 10,),
                                                if (assignments[index].injectionCompletionTime != null)
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 100.0,
                                                        child: Text("Ngày tiêm: "),
                                                      ),
                                                      Expanded(child: Text(DateFormat('dd/MM/yyyy').format(assignments[index].injectionCompletionTime!)),),
                                                    ],
                                                  ),
                                                if (assignments[index].injectionCompletionTime == null)
                                                  const Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 100.0,
                                                        child: Text("Ngày tiêm: "),
                                                      ),
                                                      Expanded(child: Text("Chưa cập nhật"),),
                                                    ],
                                                  ),

                                                const SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 100.0,
                                                      child: Text("Vị trí tiêm: "),
                                                    ),
                                                    Expanded(child: Text("${assignments[index].route}"),),
                                                  ],
                                                ),

                                                const SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 100.0,
                                                      child: Text("Tên vắc xin: "),
                                                    ),
                                                    Expanded(child: Text(assignments[index].vaccineLot.vaccine.name),),
                                                  ],
                                                ),

                                                const SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 100.0,
                                                      child: Text("Mã số lô: "),
                                                    ),
                                                    Expanded(child: Text(assignments[index].vaccineLot.lotCode),),
                                                  ],
                                                ),

                                                const SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 100.0,
                                                      child: Text("Hình thức: "),
                                                    ),
                                                    Expanded(child: Text(assignments[index].vaccineLot.vaccinationType == 'DICH_VU' ? 'TIÊM CHỦNG DỊCH VỤ' : 'TIÊM CHỦNG MỞ RỘNG'),),
                                                  ],
                                                ),

                                                const SizedBox(height: 10,),
                                              ],
                                            ),
                                          )
                                      );
                                    });
                              }
                              return const Center(child: CircularProgressIndicator());
                        })
                    ],
                  ),
                ),

              ),
            );

          }
          return Scaffold(
            appBar: AppBar(title: const Text("Lịch sử tiêm chủng"),),
            body:const Center(child: Text("Không tìm thấy thông tin tiêm chủng!")),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text("Lịch sử tiêm chủng"),),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
}
