import 'dart:io';

import '../../models/nutrition/nutrition.dart';
import 'nutrition_manager.dart';
import 'nutrition_detail_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NutritionDetailScreen extends StatefulWidget {
  static const routeName = '/nutritions';
  final String patientId;
  const NutritionDetailScreen({required this.patientId, super.key});

  @override
  State<NutritionDetailScreen> createState() => _NutritionDetailScreenState();
}

class _NutritionDetailScreenState extends State<NutritionDetailScreen> {
  late Future<void> _fetchNutritionDetails;

  @override
  void initState() {
    super.initState();
    _fetchNutritionDetails = context.read<NutritionManager>().fetchNutritionByPatientId(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _fetchNutritionDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final nutritions = snapshot.data as List<Nutrition>;
          return Scaffold(
            appBar: AppBar(title: const Text("Chỉ số cơ thể"),),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: ListView.builder(
                itemCount: nutritions.length,
                itemBuilder: (context, index) => NutritionItemCard(nutritions[index]),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text("Chỉ số cơ thể"),),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
}
