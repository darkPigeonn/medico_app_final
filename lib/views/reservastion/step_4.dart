import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medico_app/models/outlet/sublist_model.dart';
import 'package:medico_app/models/reservation/waktu_tersedia_model.dart';
import 'package:medico_app/providers/reservation/reservation_provider.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/dashboard_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CreateStep4 extends StatefulWidget {
  final Map dataSave;

  const CreateStep4({Key? key, required this.dataSave}) : super(key: key);

  @override
  State<CreateStep4> createState() => _CreateStep4State();
}

class _CreateStep4State extends State<CreateStep4> {
  late SublistModel subOutlet;
  late WaktuTersedia jam;
  late List<ServiceModel> services;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.dataSave);
    subOutlet = widget.dataSave['subList'];
    jam = widget.dataSave['time'];
    services = widget.dataSave['services'];
  }

  Widget build(BuildContext context) {
    var date = widget.dataSave['date'];
    var outputFormat = DateFormat('dd MMM yyyy');
    var newDate = outputFormat.format(date);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.all(2),
            height: double.infinity,
            child: Center(
              child: Text("step 4-4"),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Detail Reservasi",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        DetailCard(
                            value: subOutlet.parentName.toString(),
                            label: "Klinik"),
                        DetailCard(
                          value: subOutlet.name.toString(),
                          label: 'Poli',
                        ),
                        DetailCard(
                          value: newDate.toString(),
                          label: 'Tanggal Reservasi',
                        ),
                        DetailCard(value: jam.id.toString(), label: 'Jam'),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Layanan',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...services.map(
                          (e) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(e.nameCap.toString()),
                              ),
                              Container(
                                child: Text("Rp. " + e.price.toString()),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          color: mPrimary,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                        color: mWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    'Rp. ' +
                                        widget.dataSave['total'].toString(),
                                    style: TextStyle(
                                        color: mWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: mPrimary,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'TOTAL : ',
                                    style: TextStyle(
                                        color: mWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rp. ' +
                                        widget.dataSave['total'].toString(),
                                    style: TextStyle(
                                        color: mWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  onSubmit();
                                },
                                child: Text('Simpan'))
                          ],
                        )), //last one
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSubmit() async {
    var servicesTemp = [];
    print(services);
    services.forEach((element) {
      var temp = {
        'serviceId': element.id,
        'serviceName': element.name,
        'amount': element.price
      };
      servicesTemp.add(temp);
    });
    Map dataSave = {
      "subOutletId": widget.dataSave['subOuletId'],
      "reservationDate": widget.dataSave['reservationDate'],
      "services": servicesTemp,
    };
    await context
        .read(userProvider.notifier)
        .getDataProfile()
        .then((value) async {
      dataSave['patientId'] = value.id;
      await context
          .read(reservationProvider.notifier)
          .storeReservation(dataSave)
          .then((value2) {
        if (value2['code'] == 200) {
          messageSnackBarColor(context, 'Reservasi tersimpan', cSuccess);
          Navigator.pushAndRemoveUntil(
              context,
              generateScaleTransition(DashBoardScreen(
                selectedPage: 0,
              )),
              (route) => false);
        }
        // messageSnackBar(context, value['code']);
      });
    }).catchError((onError) {
      messageSnackBarColor(context, onError['msg'], cFail);
    });
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({Key? key, required this.value, required this.label})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.32,
          child: Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          child: Text(
            ' : ',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          width: 130,
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }
}

class DetailPetCard extends StatelessWidget {
  const DetailPetCard(
      {Key? key,
      required this.imageUrl,
      required this.species,
      required this.name})
      : super(key: key);

  final String imageUrl;
  final String name;
  final String species;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundColor: mPrimary,
            child: Text(
              imageUrl,
              style: TextStyle(
                color: mFillColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              name,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            child: Text(
              ' - ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: 130,
            child: Text(
              species,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
