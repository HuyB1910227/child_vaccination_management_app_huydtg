import 'package:flutter/rendering.dart';
import '../../../models/assignment/assignment.dart';
import 'package:intl/intl.dart';
import '../../../models/appointment_card/appointment_card.dart';
import '../appointment_card_manager.dart';
import '../../assignment/assignment_manager.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AppointmentCardDetailScreen extends StatefulWidget {
  static const routeName = '/appointment-card-confirmed-detail';
  final int id;
  const AppointmentCardDetailScreen(this.id, {super.key});

  @override
  State<AppointmentCardDetailScreen> createState() => _AppointmentCardDetailScreenState();
}

class _AppointmentCardDetailScreenState extends State<AppointmentCardDetailScreen> {
  late Future<AppointmentCard?> _fetchAppointmentCardById;

  @override
  void initState() {
    super.initState();
    _fetchAppointmentCardById = context.read<AppointmentCardManager>().fetchAppointmentCardById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _fetchAppointmentCardById,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final appointmentCard = snapshot.data;
          if (appointmentCard != null) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: "Thông tin chung",),
                      Tab(text: "Chỉ định tiêm"),
                    ],
                    labelColor: Colors.yellow,
                    unselectedLabelColor: Colors.white70,
                  ),
                  title: const Text('Phiếu tiêm'),
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
                                      child: Text("THÔNG TIN NGƯỜI TIÊM"),
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 100.0,
                                          child: Text("Mã số: "),
                                        ),
                                        Expanded(child: Text(' ${appointmentCard.patient.id}'),),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 100.0,
                                          child: Text("Họ và tên: "),
                                        ),
                                        Expanded(child: Text('${appointmentCard.patient.fullName}'),),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 100.0,
                                          child: Text("Giới tính: "),
                                        ),
                                        Expanded(child: Text('${appointmentCard.patient.gender == 1 ? "Nữ" : "Nam"}'),),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 100.0,
                                          child: Text("Ngày sinh: "),
                                        ),
                                        Expanded(child: Text(DateFormat('dd/MM/yyyy').format(appointmentCard.patient.dateOfBirth)),),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 100.0,
                                          child: Text("Địa chỉ: "),
                                        ),
                                        Expanded(child: Text(appointmentCard.patient.address),),
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
                                      child: Text("THÔNG TIN PHIẾU TIÊM"),
                                    ),
                                    const SizedBox(height: 10,),
                                    if(appointmentCard.appointmentDateConfirmed!=null)
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Ngày hẹn: "),
                                          ),
                                          Expanded(child: Text(DateFormat('dd/MM/yyyy').format(appointmentCard.appointmentDateConfirmed!)),),
                                        ],
                                      ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 100.0,
                                          child: Text("Cơ sở tiêm: "),
                                        ),
                                        Expanded(child: Text('${appointmentCard.immunizationUnit.name}'),),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 100.0,
                                          child: Text("Địa chỉ: "),
                                        ),
                                        Expanded(child: Text('${appointmentCard.immunizationUnit.address}'),),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 100.0,
                                          child: Text("Đường dây nóng: "),
                                        ),
                                        Expanded(child: Text(appointmentCard.immunizationUnit.hotline),),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 100.0,
                                          child: Text("Mã phiếu tiêm: "),
                                        ),
                                        Expanded(child: Text('${appointmentCard.id}')),
                                      ],
                                    ),

                                  ],
                                ),
                              )
                          ),
                          if (appointmentCard.status > 1)
                            Card(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text("BÁC SĨ CHỈ ĐỊNH"),
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Mã nhân viên: "),
                                          ),
                                          Expanded(child: Text('${appointmentCard.employee?.employeeId}'),),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 100.0,
                                            child: Text("Họ và tên: "),
                                          ),
                                          Expanded(child: Text('${appointmentCard.employee?.fullName}'),),
                                        ],
                                      ),

                                    ],
                                  ),
                                )
                            ),
                        ],
                      ),

                      FutureBuilder(
                          future: context.read<AssignmentManager>().fetchAssignmentsByAppointmentCardId(appointmentCard.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              final assignments = snapshot.data as List<Assignment>;
                              if (assignments.isEmpty) {
                                return const Center(child: Text("Chưa có thông tin chỉ định tiêm!"));
                              }
                              return ListView.builder(
                                  itemCount: assignments.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
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
                                                  Expanded(child: Text("${assignments[index].vaccineLot.lotCode}"),),
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
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 100.0,
                                                    child: Text("Tình trạng: "),
                                                  ),
                                                  Expanded(child: Text(assignments[index].status == 1 ? 'Đã tiêm' : 'Chưa tiêm'),),
                                                ],
                                              ),

                                              const SizedBox(height: 10,),
                                              if (assignments[index].injectionCompletionTime != null)
                                                Card(
                                                  color: Colors.green,
                                                  child: Padding (
                                                    padding: const EdgeInsets.all(10),
                                                    child: Column(
                                                      children: [
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 100.0,
                                                                child: Text("Thời gian tiêm: "),
                                                              ),
                                                              Expanded(child: Text(DateFormat('HH:mm').format(assignments[index].injectionCompletionTime!), style: const TextStyle(color: Colors.white),),),
                                                            ],
                                                          ),
                                                        const SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 100.0,
                                                                child: Text("Ngày tiêm: "),
                                                              ),
                                                              Expanded(child: Text(DateFormat('dd/MM/yyyy').format(assignments[index].injectionCompletionTime!), style: const TextStyle(color: Colors.white),),
                                                              ),
                                                            ],
                                                          ),
                                                        const SizedBox(height: 10,)
                                                      ],
                                                    ),
                                                  ),
                                              ),
                                            ],
                                          ),
                                        )
                                    );
                                  }
                                  );
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
            body: const Center(child: Text("Không tìm thấy thông tin tiêm chủng!")),
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
