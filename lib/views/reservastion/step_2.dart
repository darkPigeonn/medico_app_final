import 'package:flutter/material.dart';
import 'package:medico_app/models/outlet/operationalHours_model.dart';
import 'package:medico_app/models/outlet/outlet_model.dart';
import 'package:medico_app/models/outlet/sublist_model.dart';
import 'package:medico_app/models/reservation/layanan_model.dart';
import 'package:medico_app/models/reservation/loket_model.dart';
import 'package:medico_app/models/user/patient_model.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/services/reservation/master_service.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/membership_badge.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/text_style.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/reservastion/step_3.dart';
import 'package:medico_app/views/user/topup/index.dart';
import 'package:medico_app/views/user/topup/index_byadmin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class CreateStep2 extends StatefulWidget {
  final List<PatientModel> selectedAnimals;
  final SublistModel sublist;
  const CreateStep2(
      {Key? key, required this.selectedAnimals, required this.sublist})
      : super(key: key);

  @override
  _CreateStep2State createState() => _CreateStep2State();
}

class _CreateStep2State extends State<CreateStep2> {
  List<ServiceModel> selectedServices = [];
  List<ServiceModel> services = [];
  bool isLoading = false;

  int totalPrice = 0;

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
    }
  }

  renderTotalPrice() {
    totalPrice = 0;
    print(selectedServices.length);
    for (var i = 0; i < selectedServices.length; i++) {
      totalPrice = totalPrice + selectedServices[i].price!;
      // print(selectedServices[i].name);
    }
  }

  @override
  Widget build(BuildContext context) {
    services = widget.sublist.services!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(15),
                  color: mWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Buat Reservasi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Silahkan Pilih Layanan',
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...services.map((e) {
                                return Card(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      e.name
                                                          .toString()
                                                          .capitalizeFirstofEach,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.alike(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(),
                                                  Container(
                                                    child: Text('Rp ' +
                                                        e.price.toString()),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                                padding: EdgeInsets.all(5),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              e.getIsChecked()
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .blue),
                                                  onPressed: () {
                                                    setState(() {
                                                      bool selected =
                                                          e.isSelected;
                                                      e.setIsChecked(!selected);
                                                      e.getIsChecked()
                                                          ? selectedServices
                                                              .add(e)
                                                          : selectedServices
                                                              .removeWhere(
                                                                  (element) =>
                                                                      element
                                                                          .id ==
                                                                      e.id);

                                                      renderTotalPrice();
                                                    });
                                                  },
                                                  child: Text(e.getIsChecked()
                                                      ? 'Hapus'
                                                      : 'Pilih'),
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  selectedServices.length > 0
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.green,
                              width: double.infinity,
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          'Rp ' + totalPrice.toString(),
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
                                        Navigator.push(
                                          context,
                                          generateSlideTransitionHorizontal(
                                            CreateStep3(
                                              subList: widget.sublist,
                                              totalPrices: totalPrice,
                                              selectedServices:
                                                  selectedServices,
                                              selectedAnimals:
                                                  widget.selectedAnimals,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text('Selanjutnya'))
                                ],
                              )), //last one
                        )
                      : Container()
              ],
            ),
    );
  }
}
