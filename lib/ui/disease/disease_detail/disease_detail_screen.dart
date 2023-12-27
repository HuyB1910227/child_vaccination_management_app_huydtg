import 'package:flutter/material.dart';
import '../../screens.dart';
import 'package:provider/provider.dart';
import '../../../models/disease/disease.dart';
import 'disease_detail_manager.dart';

class DiseaseDetailScreen extends StatefulWidget {
  static const routeName = '/disease-detail';
  final int diseaseId;
  const DiseaseDetailScreen(this.diseaseId, {Key? key}) : super(key: key);

  @override
  State<DiseaseDetailScreen> createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen> {
  late Future<Disease?> _fetchDisease;

  @override
  void initState() {
    super.initState();
    _fetchDisease = context
        .read<DiseaseManager>()
        .fetchDiseaseWithVaccineRelationshipById(widget.diseaseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _fetchDisease,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            final disease = snapshot.data as Disease;
            return DefaultTabController(
              length: 2,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0.0,
                    pinned: false,
                    backgroundColor: Colors.grey,
                    expandedHeight: 300,
                    flexibleSpace: const FlexibleSpaceBar(
                      background: Image(
                        image: NetworkImage(
                            "https://res.cloudinary.com/dwccfildc/c_limit,f_auto,w_760/v1641488790/prod/2682dcc03896ff9d163c5223815b8aa8.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                              Tab(text: "Vắc xin phòng bệnh"),
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
                            Column(children: [
                              const Text(
                                "THÔNG TIN DỊCH BỆNH",
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
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pinkAccent)),
                                  ),
                                  Expanded(
                                    child: Text('${disease.id}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                children: <Widget>[
                                  const Expanded(
                                    child: Text('Tên loại bệnh:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pinkAccent)),
                                  ),
                                  Expanded(
                                    child: Text(disease.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                children: <Widget>[
                                  const Expanded(
                                    child: Text('Mô tả:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pinkAccent)),
                                  ),
                                  Expanded(
                                    child: Text(disease.description,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ]),


                            if (disease.vaccines?.length !=
                                null)
                              Column(
                                children: disease.vaccines!
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
                                              VaccineDetailScreen
                                                  .routeName,
                                              arguments:
                                              disease
                                                  .id);
                                        },
                                        color: Colors.pink,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            if (disease.vaccines?.length ==
                                null)
                              const Center(
                                child: Text(
                                    "Không tìm thấy văc xin phòng ngừa cho bệnh này"),
                              ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Tra cứu dịch bệnh"),
              ),
              body: const Text(
                  'Không tìm thấy thông tin loại bệnh này! Vui lòng thử lại sau'),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    )

        );
  }
}
