import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './patient_detail/patient_detail_screen.dart';
import '../nutrition/nutrition_detail_screen.dart';
import '../../models/patient/patient_general_information.dart';
import '../assignment/disease_group/disease_group_general_screen.dart';
import 'package:intl/intl.dart';
import '../avatar/avatar_manager.dart';

class PatientGeneralInformationItemCard extends StatefulWidget {
  final PatientGeneralInformation patientGeneralInformation;
  const PatientGeneralInformationItemCard(this.patientGeneralInformation,
      {super.key});

  @override
  State<PatientGeneralInformationItemCard> createState() =>
      _PatientGeneralInformationItemCardState();
}

class _PatientGeneralInformationItemCardState
    extends State<PatientGeneralInformationItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildPatientGeneralInformationSummary(),
          if (_expanded) buildOtherOption(),
        ],
      ),
    );
  }

  Widget buildPatientGeneralInformationSummary() {
    return ListTile(
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.patientGeneralInformation.avatar != null)
            FutureBuilder(
              future: context.read<AvatarManager>().loadImageWithAvatarName(widget.patientGeneralInformation.avatar!),
              initialData: const CircleAvatar(
                backgroundImage: AssetImage('assets/default_avatar.jpg'),
                radius: 25,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // Xử lý lỗi tải hình ảnh
                    return const CircleAvatar(
                      backgroundImage: AssetImage('assets/default_avatar.jpg'),
                      radius: 25,
                    );
                  } else {
                    return CircleAvatar(
                      backgroundImage: MemoryImage(
                        snapshot.data as Uint8List,
                      ),
                      radius: 25,
                    );
                  }
                } else {
                  // Hiển thị gì đó khi đang tải ảnh
                  return const CircleAvatar(
                    backgroundImage: AssetImage('assets/default_avatar.jpg'),
                    radius: 25,
                  );
                }
              },
            ),
          if (widget.patientGeneralInformation.avatar == null)
            const CircleAvatar(
              backgroundImage: AssetImage('assets/default_avatar.jpg'),
              radius: 25,
            ),
        ],
      ),
      title: Text(widget.patientGeneralInformation.fullName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text('Ngày sinh: ${DateFormat('dd/MM/yyyy').format(widget.patientGeneralInformation.dateOfBirth)}'),
        ],
      ),
      trailing: IconButton(
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        color: Colors.purple,
      ),
    );
  }

  Widget buildOtherOption() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                  PatientDetailScreen.routeName,
                  arguments: widget.patientGeneralInformation.id,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(0),
              primary: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.purple),
              ),
            ),
            child: Ink(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  alignment: Alignment.centerLeft,
                  child: const Text("Thông tin chi tiết", style: TextStyle(color: Colors.purpleAccent)),
                )),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                DiseaseGroupGeneralScreen.routeName,
                arguments: widget.patientGeneralInformation.id,
              );

            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(0),
              primary: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.purple),
              ),
            ),
            child: Ink(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  alignment: Alignment.centerLeft,
                  child: Text("Nhật ký tiêm chủng", style: TextStyle(color: Colors.purpleAccent)),
                )),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                NutritionDetailScreen.routeName,
                arguments: widget.patientGeneralInformation.id,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(0),
              primary: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.purple),
              ),
            ),
            child: Ink(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  alignment: Alignment.centerLeft,
                  child: Text("Chỉ số cơ thể", style: TextStyle(color: Colors.purpleAccent)),
                )),
          ),

        ],
      ),
    );
  }
}
