import 'dart:io';

import '../../../models/assignment/assignment.dart';
import '../assignment_manager.dart';
import 'assignment_detail_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AssignmentDetailScreen extends StatefulWidget {
  static const routeName = '/assignment-detail';
  final List<int> assignmentIds;
  const AssignmentDetailScreen(this.assignmentIds, {super.key});

  @override
  State<AssignmentDetailScreen> createState() => _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState extends State<AssignmentDetailScreen> {
  late Future<List<Assignment>> _fetchAssignmentsDetails;

  @override
  void initState() {
    super.initState();
    _fetchAssignmentsDetails = context.read<AssignmentManager>().fetchAssignmentsByIds(widget.assignmentIds);
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _fetchAssignmentsDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final assignments = snapshot.data as List<Assignment>;
          if (assignments.length > 0) {
            return Scaffold(
              appBar: AppBar(title: const Text("Thông tin tiêm chủng"),),
              body: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder: (context, index) => AssignmentItemCard(assignments[index], index + 1),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(title: const Text("Thông tin tiêm chủng"),),
            body:Center(child: Text("Trẻ chưa tiêm vắc xin thuộc nhóm bệnh này!")),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text("Thông tin tiêm chủng"),),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
}
