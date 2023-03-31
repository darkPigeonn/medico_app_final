import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medico_app/models/outlet/sublist_model.dart';
import 'package:medico_app/models/reservation/waktu_tersedia_model.dart';
import 'package:medico_app/models/user/patient_model.dart';
import 'package:medico_app/providers/reservation/reservation_provider.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/text_style.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/dashboard_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../utils/helpers.dart';

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
  late List<PatientModel> animals;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subOutlet = widget.dataSave['subList'];
    jam = widget.dataSave['time'];
    services = widget.dataSave['services'];
    animals = widget.dataSave['patients'];
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
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Detail Reservasi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Hewan',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...animals.map((e) => Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 22.0,
                                              backgroundImage: NetworkImage(
                                                  'https://paradepets.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTkxMzY1Nzg4NjczMzIwNTQ2/cutest-dog-breeds-jpg.jpg'),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              e.petName!.toUpperCase(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(' - '),
                                            Text(
                                              e.species!.toUpperCase(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Layanan',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ...services.map(
                                (e) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(e.name
                                          .toString()
                                          .capitalizeFirstofEach),
                                    ),
                                    Container(
                                      child: Text("Rp. " +
                                          CurrencyFormat.convertToIdr(
                                              e.price, 2)),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Tanggal',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(newDate.toString()),
                              Divider(),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Jam',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(jam.id.toString()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Catatan : ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      child: Text(
                        '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 0, 140, 255)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          Text(
                            'Rp. ' +
                                CurrencyFormat.convertToIdr(
                                    widget.dataSave['total'], 2),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await onSubmit();
                          },
                          child: Text('Simpan'))
                    ],
                  )), //last one
            )
          ],
        ),
      ),
    );
  }

  onSubmit() async {
    var animalsSelected = [];
    var servicesTemp = [];

    animals.forEach((element) {
      var temp = {'patientId': element.id, 'patientName': element.petName};
      animalsSelected.add(temp);
    });
    services.forEach((element) {
      var temp = {
        'serviceId': element.id,
        'serviceName': element.name,
        'amount': element.price
      };
      servicesTemp.add(temp);
    });
    Map dataSave = {
      "patients": animalsSelected,
      "subOutletId": widget.dataSave['subOuletId'],
      "reservationDate": widget.dataSave['reservationDate'],
      "services": servicesTemp,
    };


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
