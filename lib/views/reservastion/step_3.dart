import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medico_app/models/outlet/operationalHours_model.dart';
import 'package:medico_app/models/outlet/sublist_model.dart';
import 'package:medico_app/models/reservation/layanan_model.dart';
import 'package:medico_app/models/reservation/loket_model.dart';
import 'package:medico_app/models/reservation/waktu_tersedia_model.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/services/reservation/master_service.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/membership_badge.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/reservastion/step_3.dart';
import 'package:medico_app/views/reservastion/step_4.dart';
import 'package:medico_app/views/user/topup/index.dart';
import 'package:medico_app/views/user/topup/index_byadmin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class CreateStep3 extends StatefulWidget {
  final SublistModel subList;
  final int totalPrices;
  final List<ServiceModel> selectedServices;
  const CreateStep3(
      {Key? key,
      required this.subList,
      required this.totalPrices,
      required this.selectedServices})
      : super(key: key);

  @override
  _CreateStep2State createState() => _CreateStep2State();
}

class _CreateStep2State extends State<CreateStep3> {
  bool isLoading = false;
  DateTime? selectedDate;
  DateTime beforeNow = DateTime.now();
  DateTime now = DateTime.now();

  List<WaktuTersedia> hoursAvailable = [];
  WaktuTersedia selectedWaktu = WaktuTersedia();

  initialData() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      // _timer = new Timer.periodic(Duration(seconds: 5), (timer) async {
      //   getSaldoStream();
      // });
      initialData();
      final hours = widget.subList.operationalHours;
      hours!.map((e) => print(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = widget.subList.operationalHours;
    hours!.map((e) => print(e));
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.all(2),
            height: double.infinity,
            child: Center(
              child: Text("step 2-3"),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: mPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          'Klinik - Adi Utama',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: mWhite,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Poli Umum',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: mWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SafeArea(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text('Silahkan Pilih Tanggal ')),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final DateTime? selected =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: beforeNow,
                                      firstDate: beforeNow,
                                      lastDate: DateTime(beforeNow.year + 5),
                                    );
                                    if (selected != null &&
                                        selected != selectedDate) {
                                      checkTimeAvailable(selected);
                                      setState(() {
                                        selectedDate = selected;
                                      });
                                    }
                                  },
                                  child: Text(
                                    selectedDate == null
                                        ? "-Pilih Tanggal-"
                                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white, // background
                                    onPrimary: Colors.black, // foreground
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text('Silahkan Pilih Jam Operasional'),
                              ),
                              Container(
                                  child: Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...hoursAvailable.map(
                                        (value) {
                                          if (value.enabled) {
                                            return RadioListTile<WaktuTersedia>(
                                              title:
                                                  Text(value.label.toString()),
                                              value: value,
                                              activeColor: mBlack,
                                              groupValue: selectedWaktu,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedWaktu = value!;
                                                });
                                              },
                                            );
                                          } else {
                                            return ListTile(
                                              leading: Icon(Icons.close),
                                              title:
                                                  Text(value.label.toString()),
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
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
                                    'Rp ' + widget.totalPrices.toString(),
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
                                  if (selectedDate == null ||
                                      selectedWaktu == null) {
                                    messageSnackBarColor(
                                        context,
                                        "Tanggal & Jam masih kosong!",
                                        Colors.red);
                                  } else {
                                    var reservationDate =
                                      selectedDate.toString() +
                                          ',' +
                                          selectedWaktu.label.toString();


                                    var objectSave = {
                                      "subList": widget.subList,
                                      "subOuletId": widget.subList.id,
                                      "date": selectedDate,
                                      "time": selectedWaktu,
                                      "reservationDate": reservationDate,
                                      "services": widget.selectedServices,
                                      "total": widget.totalPrices
                                    };

                                    Navigator.push(
                                        context,
                                        generateSlideTransitionHorizontal(
                                          CreateStep4(
                                            dataSave: objectSave,
                                          ),
                                        ));
                                  }
                                  // );
                                },
                                child: Text('Selanjutnya'))
                          ],
                        )), //last one
                  )
                ],
              ),
            ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkTimeAvailable(DateTime date) async {
    var subOutletId = widget.subList.id;
    await MasterService()
        .getWaktuTersedia(subOutletId!, "${date.toLocal().toIso8601String()}Z")
        .then((value) {
      setState(() {
        hoursAvailable = value;
      });
    });

    print(hoursAvailable);
  }
}
