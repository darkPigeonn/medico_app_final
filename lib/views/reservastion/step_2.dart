import 'package:flutter/material.dart';
import 'package:medico_app/models/outlet/operationalHours_model.dart';
import 'package:medico_app/models/outlet/outlet_model.dart';
import 'package:medico_app/models/outlet/sublist_model.dart';
import 'package:medico_app/models/reservation/layanan_model.dart';
import 'package:medico_app/models/reservation/loket_model.dart';
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
import 'package:medico_app/views/user/topup/index.dart';
import 'package:medico_app/views/user/topup/index_byadmin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class CreateStep2 extends StatefulWidget {
  final SublistModel sublist;
  const CreateStep2({Key? key, required this.sublist}) : super(key: key);

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
    print(services);

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
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: SafeArea(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                ...services.map(
                                  (e) {
                                    return Card(
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    height: 90,
                                                    child: SvgPicture.asset(
                                                      'assets/suboutlet.svg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        child: Text(
                                                          e.nameCap.toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              GoogleFonts.alike(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      Divider(),
                                                      Container(
                                                        child: Text('Rp. ' +
                                                            e.price.toString()),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: e
                                                                        .getIsChecked()
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .blue),
                                                        onPressed: () {
                                                          setState(() {
                                                            bool selected =
                                                                e.isSelected;
                                                            e.setIsChecked(
                                                                !selected);
                                                            e.getIsChecked()
                                                                ? selectedServices
                                                                    .add(e)
                                                                : selectedServices.removeWhere(
                                                                    (element) =>
                                                                        element
                                                                            .id ==
                                                                        e.id);

                                                            renderTotalPrice();
                                                          });
                                                        },
                                                        child: Text(
                                                            e.getIsChecked()
                                                                ? 'Hapus'
                                                                : 'Pilih'),
                                                      ))
                                                ],
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  selectedServices.length > 0
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
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
                                          'Rp. ' + totalPrice.toString(),
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
}
