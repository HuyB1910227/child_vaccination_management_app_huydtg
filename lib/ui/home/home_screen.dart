import 'package:flutter/material.dart';

import 'working_schedule_suggestion_list.dart';
import 'working_schedule_suggestion_search.dart';
import 'package:provider/provider.dart';
import 'menu_data.dart';
import '../screens.dart';
import '../notification/notification_navigate_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuData> menu = [
      MenuData(Icons.vaccines_outlined, "Vắc xin",
          VaccineGeneralInformationScreen.routeName, Colors.purpleAccent),
      MenuData(Icons.medication, "Dịch bệnh",
          DiseaseGeneralInformationScreen.routeName, Colors.purpleAccent),
      MenuData(
          Icons.local_hospital_outlined,
          "Cơ sở",
          ImmunizationUnitGeneralInformationScreen.routeName,
          Colors.purpleAccent),
      MenuData(Icons.history, "Lịch sử tiêm",
          HistoryGeneralInformationScreen.routeName, Colors.purpleAccent),

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [NotificationNavigateButton()],
      ),
      body: Container(
        child: Scrollbar(
          thickness: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Center(
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 28,
                        children: menu
                            .map((e) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // print("đã click route");
                                        Navigator.of(context).pushNamed(
                                          e.routerName,
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Card(
                                            color: e.color,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 15.0),
                                              child: Icon(
                                                e.icon,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            e.title,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                            .toList()),
                  ),
                  const SizedBox(height: 10,),



                  // const SizedBox(height: 10,),
                  const WorkingScheduleSuggestionList(),

                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
