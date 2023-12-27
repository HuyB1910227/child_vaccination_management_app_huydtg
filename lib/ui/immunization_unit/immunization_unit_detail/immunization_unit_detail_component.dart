

import 'package:flutter/material.dart';
import '../../../models/immunization_unit/immunization_unit.dart';
class ImmunizationUnitDetailInfo extends StatelessWidget {
  final ImmunizationUnit immunizationUnit;

  const ImmunizationUnitDetailInfo({required this.immunizationUnit, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Mã cơ sở:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent)),
          ),
          Expanded(
            child: Text('${immunizationUnit.id}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Tên cơ sở:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent)),
          ),
          Expanded(
            child: Text(immunizationUnit.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Địa chỉ:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent)),
          ),
          Expanded(
            child: Text(immunizationUnit.address,
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Mã giấy phép:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent)),
          ),
          Expanded(
            child: Text(immunizationUnit.operatingLicence,
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Hỗ trợ:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent)),
          ),
          Expanded(
            child: Text(immunizationUnit.hotline,
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Row(
        children: <Widget>[
          const Expanded(
            child: Text('Trạng thái:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent)),
          ),
          Expanded(
            child: Text(immunizationUnit.isActive == true ? "Cấp phép hoạt động" : "Ngừng hoạt động",
                style: const TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ]);
  }
}
