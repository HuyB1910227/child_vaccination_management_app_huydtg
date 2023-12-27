import 'package:flutter/material.dart';
import '../../fixed_schedule/calendar/fixed_working_schedule_immunization_unit_component.dart';
import '../../../models/vaccine_lot/vaccine_available.dart';
import '../../fixed_schedule/fixed_schedule_manager.dart';
import '../../screens.dart';
import 'package:provider/provider.dart';
import '../../../models/immunization_unit/immunization_unit.dart';
import 'immunization_unit_detail_manager.dart';
import 'immunization_unit_detail_component.dart';
import '../../../models/fixed_schedule/fixed_schedule.dart';
import '../../vaccine_lot/vaccine_lot_manager.dart';
import '../../vaccine_lot/vaccine_available/vaccine_available_card.dart';
class ImmunizationUnitDetailScreen extends StatefulWidget {
  static const routeName = '/immunization-unit';
  final String immunizationUnitId;
  const ImmunizationUnitDetailScreen(this.immunizationUnitId, {Key? key}) : super(key: key);

  @override
  State<ImmunizationUnitDetailScreen> createState() => _ImmunizationUnitDetailScreenState();
}

class _ImmunizationUnitDetailScreenState extends State<ImmunizationUnitDetailScreen> {
  late Future<ImmunizationUnit?> _fetchImmunizationUnit;

  @override
  void initState() {
    super.initState();
    _fetchImmunizationUnit = context
        .read<ImmunizationUnitManager>()
        .fetchImmunizationUnitById(widget.immunizationUnitId);
  }

  @override
  Widget build(BuildContext context) {
    return
    FutureBuilder(
        future: _fetchImmunizationUnit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final immunizationUnit = snapshot.data as ImmunizationUnit;
            if (immunizationUnit != null ) {
              return DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: AppBar(

                      bottom: const TabBar(
                        tabs: [
                          Tab(text: "Thông tin",),
                          Tab(text: "Lịch làm việc"),
                          Tab(text: "Vắc xin"),
                        ],
                        labelColor: Colors.yellow,
                        unselectedLabelColor: Colors.white70,
                      ),
                      title: const Text('Cơ sở tiêm chủng'),
                    ),
                    body: 
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TabBarView(
                            children: [
                              ImmunizationUnitDetailInfo(immunizationUnit: immunizationUnit),
                              immunizationUnit.isActive
                                  ? FixedWorkingScheduleImmunizationUnitComponent(immunizationUnitId: widget.immunizationUnitId)
                                  : const Center(child: Text("Cơ sở tạm ngừng hoạt động! Quý khách vui lòng thử lại sau."),),
                              immunizationUnit.isActive ?
                                  FutureBuilder(
                                      future: context.read<VaccineLotManager>().fetchVaccineAvailableByImmunizationUnitId(immunizationUnit.id),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          final vaccinesAvailable = snapshot.data as List<VaccineAvailable>;
                                          return ListView.builder(
                                              itemCount: vaccinesAvailable.length,
                                              itemBuilder: (context, index) => VaccineAvailableInformationItemCard(vaccinesAvailable[index]));
                                        } else {
                                          return const Center(child: Text("Đang tìm kiếm vắc xin..."),);
                                        }
                                  })
                                  : const Center(child: Text("Cơ sở tạm ngừng hoạt động! Quý khách vui lòng thử lại sau."),),
                            ],
                          ),
                        ),
                    
                  ),
              );
            }
            else {
              Scaffold(
                appBar: AppBar(
                  title: const Text("Cơ sở tiêm chủng"),
                ),
                body: const Text("Không tìm thấy thông tin cơ sở!"),
              );
            }
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cơ sở tiêm chủng"),
            ),
            body: const CircularProgressIndicator(),
          );
    });
  }
}
