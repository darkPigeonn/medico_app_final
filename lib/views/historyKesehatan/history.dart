import 'package:flutter/material.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/text_library.dart';
import 'package:medico_app/views/historyKesehatan/historyDetails.dart';
import 'package:medico_app/views/historyKesehatan/historyInput.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_moment/simple_moment.dart';

class HistoryMedic extends StatefulWidget {
  const HistoryMedic({Key? key}) : super(key: key);

  @override
  State<HistoryMedic> createState() => _HistoryMedicState();
}

class _HistoryMedicState extends State<HistoryMedic> {
  late int numberDummy = 0;
  late List<Vital> listVital = [];

  changeNumberDummy(data) {
    late int tempNumber = 0;
    switch (data) {
      case 0:
        tempNumber = 0;
        break;
      case 1:
        tempNumber = 1;
        break;
      case 2:
        tempNumber = 2;
        break;
      case 3:
        tempNumber = 3;
        break;
      case 4:
        tempNumber = 4;
        break;
      case 5:
        tempNumber = 5;
        break;
      case 6:
        tempNumber = 6;
        break;
      case 7:
        tempNumber = 7;
        break;
      case 8:
        tempNumber = 8;
        break;
      case 9:
        tempNumber = 9;
        break;
      case 10:
        tempNumber = 10;
        break;
      default:
    }
    setState(() {
      numberDummy = tempNumber;
    });
  }

  Future<void> getVitalPatient() async {
    bool isconnected = await CheckConnectivity.checkConnection();

    if (isconnected) {
      context.read(userProvider.notifier).getDataProfile().then((value) {
        setDataVital(value);
      });
    }
  }

  setDataVital(UserModel data) {
    setState(
      () {
        listVital = data.vital!;
        listVital.map((e) => print(e));
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('object da');
    getVitalPatient();
  }

  onGoBack() {
    setState(() {
      getVitalPatient();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mPrimary,
        title: Text('Data Kesehatanku'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      changeNumberDummy(0);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          bloodPleasure,
                                          style: TextStyle(color: Colors.white),
                                        )))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      changeNumberDummy(1);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          hr,
                                          style: TextStyle(color: Colors.white),
                                        )))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      changeNumberDummy(2);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          sp02,
                                          style: TextStyle(color: Colors.white),
                                        )))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      changeNumberDummy(3);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          totalCholesterol,
                                          style: TextStyle(color: Colors.white),
                                        )))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      changeNumberDummy(4);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          gSewaktu,
                                          style: TextStyle(color: Colors.white),
                                        )))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      changeNumberDummy(5);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          gPuasa,
                                          style: TextStyle(color: Colors.white),
                                        )))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      changeNumberDummy(6);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          g2jpp,
                                          style: TextStyle(color: Colors.white),
                                        )))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      changeNumberDummy(7);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          bodyWeight,
                                          style: TextStyle(color: Colors.white),
                                        )))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      changeNumberDummy(8);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          bodyHeight,
                                          style: TextStyle(color: Colors.white),
                                        )))),
                          ])),
                ),
                Container(
                    height: size.height,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 224, 224, 224),
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: listVital.length > 0
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listVital.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HistoryDetail(
                                                dataDetail: listVital[index],
                                              )));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffe1e1e1),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      const SizedBox(width: 20),
                                      Text(
                                        Moment.parse(listVital[index]
                                                .createdAt
                                                .toString())
                                            .format('dd MMMM yyyy'),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      const SizedBox(width: 5),
                                      vitalWidget(index, numberDummy),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                ),
                              );

                              // return InkWell(
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => HistoryDetail()));
                              //   },
                              //   child: ListTile(
                              //     title: Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //       children: [
                              //         Text('20 Agustus 2022 '),
                              //         //value
                              //         Text(dummy[numberDummy]['value'] +
                              //             ' ' +
                              //             dummy[numberDummy]['satuan']),
                              //       ],
                              //     ),
                              //     trailing: IconButton(
                              //       icon: Icon(Icons.arrow_right_sharp),
                              //       onPressed: () {
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (context) => HistoryDetail()));
                              //       },
                              //     ),
                              //   ),
                              // );
                            })
                        : Center(
                            child: CircularProgressIndicator(),
                          ))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryInput()))
              .then((value) => onGoBack());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget vitalWidget(int index, int numberVital) {
    switch (numberVital) {
      case 0:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(listVital[index].tensiSistole.toString() +
                ' / ' +
                listVital[index].tensiDiastole.toString()),
            SizedBox(
              width: 10,
            ),
            Text(mmHg)
          ],
        );
      case 1:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(listVital[index].tensiPulse.toString()),
          SizedBox(
            width: 10,
          ),
          Text(sBpm)
        ]);
      case 2:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(listVital[index].oxygen.toString()),
          SizedBox(
            width: 10,
          ),
          Text(sPersen)
        ]);

      case 3:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(listVital[index].kolestrol.toString()),
          SizedBox(
            width: 10,
          ),
          Text(sMgDl)
        ]);

      case 4:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(listVital[index].glucose.toString()),
          SizedBox(
            width: 10,
          ),
          Text(sMgDl)
        ]);

      case 5:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(listVital[index].darahPuasa.toString()),
          SizedBox(
            width: 10,
          ),
          Text(sMgDl)
        ]);

      case 6:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(listVital[index].darah2Jam.toString()),
          SizedBox(
            width: 10,
          ),
          Text(sMgDl)
        ]);

      case 7:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(listVital[index].weight.toString()),
          SizedBox(
            width: 10,
          ),
          Text(sKg)
        ]);
        ;

      case 8:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(listVital[index].height.toString()),
          SizedBox(
            width: 10,
          ),
          Text(sCm)
        ]);

      case 9:
        return Text('');

      case 10:
        return Text('');
        ;

      default:
        return Text('');
    }
  }
}

class dataVital extends StatelessWidget {
  const dataVital(
      {Key? key,
      required this.size,
      required this.title,
      required this.content})
      : super(key: key);

  final Size size;
  final String title;
  final List content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Data : '),
        Container(
          margin: EdgeInsets.only(left: 2, top: 2),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: content.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Container(width: size.width * 0.5, child: Text(title)),
                  Container(
                      width: size.width * 0.1,
                      child: Text(content[index]['value'])),
                  Container(child: Text(content[index]['satuan'])),
                ],
              );
              // return ListTile(
              //     trailing: Text(satuan),
              //     title: Text(
              //       value,
              //       style: content_titleCard,
              //     ));
            },
          ),
        ),
      ],
    );
  }
}
