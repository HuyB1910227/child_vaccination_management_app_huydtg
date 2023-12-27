import 'package:flutter/material.dart';

import '../../screens.dart';
import 'package:provider/provider.dart';
import '../../../models/vaccine/vaccine.dart';
import '../../../models/age/age.dart';
import '../../../models/injection/injection_group_by_age.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class VaccineDetailScreen extends StatefulWidget {
  static const routeName = '/vaccine-detail';
  final String vaccineId;

  const VaccineDetailScreen(this.vaccineId, {Key? key}) : super(key: key);

  @override
  State<VaccineDetailScreen> createState() => _VaccineDetailScreenState();
}

class _VaccineDetailScreenState extends State<VaccineDetailScreen> {
  late Future<Vaccine?> _fetchVaccine;
  // late Future<Age?> _fetchAge(String id);

  String translateAgeType(String ageType) {
    String result = "Không xác định";
    if (ageType == "TUAN") {
      result = "tuần tuổi";
    } else if (ageType == "THANG") {
      result = "tháng tuổi";
    } else if (ageType == "TUOI") {
      result = "tuổi";
    }
    return result;
  }

  String translateInjectionDistanceType(String type) {
    String result = "Không xác định";
    if (type == "TUAN") {
      result = "tuần";
    } else if (type == "THANG") {
      result = "tháng";
    } else if (type == "NAM") {
      result = "năm";
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    _fetchVaccine =
        context.read<VaccineManager>().fetchVaccineById(widget.vaccineId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _fetchVaccine,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            final vaccine = snapshot.data as Vaccine;
            // print(vaccine.description);
            return FutureBuilder(
              future:
                  context.read<AgeManager>().fetchAgeByVaccineId(vaccine.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final List<Age> ages = snapshot.data as List<Age>;
                    return FutureBuilder(
                        future: context
                            .read<InjectionManager>()
                            .fetchInjectionByAges(ages),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final List<InjectionGroupByAge>
                                  injectionGroupByAges =
                                  snapshot.data as List<InjectionGroupByAge>;
                              return DefaultTabController(
                                length: 3,
                                child: CustomScrollView(
                                  slivers: [
                                    SliverAppBar(
                                      elevation: 0.0,
                                      pinned: true,
                                      backgroundColor: Colors.grey,
                                      expandedHeight: 300,
                                      flexibleSpace: const FlexibleSpaceBar(
                                        background: Image(
                                          image: NetworkImage(
                                              "https://media.vneconomy.vn/w800/images/upload/2023/01/31/vaccine.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      bottom: PreferredSize(
                                        preferredSize: const Size.fromHeight(
                                            kToolbarHeight),
                                        child: Container(
                                          padding: const EdgeInsets.all(3.0),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            boxShadow: const <BoxShadow>[
                                              BoxShadow(
                                                color:
                                                    Color.fromARGB(64, 0, 0, 0),
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: TabBar(
                                              unselectedLabelColor:
                                                  Colors.black,
                                              tabs: const [
                                                Tab(text: "Tổng quan"),
                                                Tab(text: "Miễn dịch"),
                                                Tab(text: "Giai đoạn tiêm"),
                                              ],
                                              indicator: BoxDecoration(
                                                color: Colors.pink,
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: 2000.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TabBarView(
                                            children: <Widget>[
                                              Column(
                                                children: [
                                                  const Text(
                                                    "THÔNG TIN VẮC XIN",
                                                    style: TextStyle(
                                                        color: Colors.pink,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      const Expanded(
                                                        child: Text('Mã số:',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .pinkAccent)),
                                                      ),
                                                      Expanded(
                                                        child: Text(vaccine.id,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      const Expanded(
                                                        child: Text('Tên:',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .pinkAccent)),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            vaccine.name,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      const Expanded(
                                                        child: Text(
                                                            'Liều lượng:',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .pinkAccent)),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            '${vaccine.dosage} ml',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      const Expanded(
                                                        child: Text(
                                                            'Phản ứng thường gặp:',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .pinkAccent)),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            vaccine.vaccineType
                                                                .name,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      const Expanded(
                                                        child: Text(
                                                            'Phân loại:',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .pinkAccent)),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            vaccine
                                                                .commonReaction,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  HtmlWidget(vaccine.description),
                                                  HtmlWidget(vaccine.contraindication),

                                                ],
                                              ),

                                              if (vaccine.diseases?.length !=
                                                  null)
                                                Column(
                                                  children: vaccine.diseases!
                                                      .map((disease) {
                                                    return Card(
                                                      child: ListTile(
                                                        title: Text(disease.name),
                                                        trailing: IconButton(
                                                          icon: const Icon(Icons
                                                              .navigate_next),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pushNamed(
                                                                DiseaseDetailScreen
                                                                    .routeName,
                                                                arguments:
                                                                disease
                                                                    .id);
                                                          },
                                                          color: Colors.purple,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              if (vaccine.diseases?.length ==
                                                  null)
                                                const Center(
                                                  child: Text(
                                                      "Không tìm thấy thông tin miễn dịch"),
                                                ),


                                              if(injectionGroupByAges.length > 0)
                                                Column(
                                                  children: injectionGroupByAges.map((group) => Card(
                                                    child: Column(
                                                      children: [
                                                        ListTile(title: Text(
                                                              "Từ ${group.age.minAge} (${translateAgeType(group.age.minAgeType)}) đến ${group.age.maxAge} (${translateAgeType(group.age.maxAgeType ?? '')})",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .purpleAccent),
                                                            ), trailing: const Icon(Icons.access_time),),
                                                        if ((group.injections?.length ?? 0) > 0)
                                                          Column(
                                                            children: group.injections!.map((injection) => ListTile(leading: Text(
                                                                          "Lần ${injection?.injectionTime}"),
                                                                      trailing:
                                                                          Text(
                                                                        injection?.injectionTime ==
                                                                                1
                                                                            ? "Mũi tiêm đầu tiên"
                                                                            : "Cách mũi tiêm trước: ${injection?.distanceFromPrevious} (${translateInjectionDistanceType(injection?.distanceFromPreviousType ?? "new romantic")})",
                                                                      ),)).toList(),
                                                          ),
                                                        if ((group.injections?.length ?? 0) == 0)
                                                          const Center(child: Text("Chưa có thông tin mũi tiêm!"),),
                                                      ],
                                                    ),
                                                  )).toList(),
                                                ),
                                              if (injectionGroupByAges.length == 0)
                                                const Center(child: Text("Không tìm thấy giai đoạn tiêm!"),)

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const Text(
                                  "Không tìm thấy thông tin các giai đoạn tiêm!");
                            }
                          } else {
                            return const Text(
                                "Không tìm thấy thông tin các giai đoạn tiêm!");
                          }
                        });
                  } else {
                    return DefaultTabController(
                      length: 2,
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            elevation: 0.0,
                            pinned: true,
                            backgroundColor: Colors.grey,
                            expandedHeight: 300,
                            flexibleSpace: const FlexibleSpaceBar(
                              background: Image(
                                image: NetworkImage(
                                    "https://media.vneconomy.vn/w800/images/upload/2023/01/31/vaccine.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            bottom: PreferredSize(
                              preferredSize:
                                  const Size.fromHeight(kToolbarHeight),
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                      color: Color.fromARGB(64, 0, 0, 0),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TabBar(
                                    unselectedLabelColor: Colors.black,
                                    tabs: const [
                                      Tab(text: "Tổng quan"),
                                      Tab(text: "Miễn dịch"),
                                    ],
                                    indicator: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 700.0,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TabBarView(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        const Text(
                                          "THÔNG TIN VẮC XIN",
                                          style: TextStyle(
                                              color: Colors.pink,
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Expanded(
                                              child: Text('Mã số:',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .pinkAccent)),
                                            ),
                                            Expanded(
                                              child: Text(vaccine.id,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Expanded(
                                              child: Text('Tên:',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .pinkAccent)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  vaccine.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Expanded(
                                              child: Text(
                                                  'Liều lượng:',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .pinkAccent)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  '${vaccine.dosage} ml',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Expanded(
                                              child: Text(
                                                  'Phản ứng thường gặp:',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .pinkAccent)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  vaccine.vaccineType
                                                      .name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Expanded(
                                              child: Text(
                                                  'Phân loại:',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .pinkAccent)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  vaccine
                                                      .commonReaction,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    if (vaccine.diseases?.length !=
                                        null)
                                      Column(
                                        children: vaccine.diseases!
                                            .map((disease) {
                                          return Card(
                                            child: ListTile(
                                              title: Text(disease.name),
                                              trailing: IconButton(
                                                icon: const Icon(Icons
                                                    .navigate_next),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                      DiseaseDetailScreen
                                                          .routeName,
                                                      arguments:
                                                      disease
                                                          .id);
                                                },
                                                color: Colors.purple,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    if (vaccine.diseases?.length ==
                                        null)
                                      const Center(
                                        child: Text(
                                            "Không tìm thấy thông tin miễn dịch"),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return const Text("Có lỗi xảy ra!");
                }
              },
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Tra cứu vắc xin"),
              ),
              body: const Text(
                  'Không tìm thấy thông tin vắc xin này! Vui lòng thử lại sau'),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
