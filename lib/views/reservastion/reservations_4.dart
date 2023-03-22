import 'package:flutter/material.dart';
import 'package:medico_app/views/reservastion/step_4.dart';

import '../../utils/const_color.dart';
import '../../utils/message.dart';
import '../../utils/transition.dart';
import '../dashboard_screen.dart';

class Reservations_4 extends StatefulWidget {
  const Reservations_4({super.key});

  @override
  State<Reservations_4> createState() => _ReservationsState_4();
}

class _ReservationsState_4 extends State<Reservations_4> {
  List<String> _listServices = [];

  String _selectedServices = '';

  DateTime? selectedDate;
  DateTime beforeNow = DateTime.now();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Reservasi',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DetailPetCard(
                    species: 'Anjing',
                    name: 'MacDonald',
                    imageUrl: '',
                  ),
                  DetailPetCard(
                    species: 'Anjing',
                    name: 'MacDonald',
                    imageUrl: '',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // ...services.map(
                          //   (e) =>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Groming',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                // formatDate('widget.data.reservationDate'),
                                '23 Maret 2022',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '08.00',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10, left: 10),
                                child: Divider(
                                  color: mBlack,
                                ),
                              ),
                            ],
                          ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('Catatan : '),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                        'adsfasdfasdfasdfadsfasdfasdfasdfadsfasdfasdfasdfadsfasdfasdfasdfadsfasdfasdfasdfadsfasdfasdfasdfadsfasdfasdfasdfadsfasdfasdfasdf'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     color: mWhite,
                  //     borderRadius: BorderRadius.circular(
                  //       10,
                  //     ),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Text(
                  //         'TOTAL',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       Text(
                  //         'Rp 50.000',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  // Center(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // showAlertDialog(context, widget.data.id.toString());
                  //     },
                  //     style:
                  //         ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  //     child: Text('Batalkan'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   '$total',
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
              ElevatedButton(
                child: Text('Simpan'),
                onPressed: () {
                  messageSnackBarColor(
                      context, 'Reservasi tersimpan', cSuccess);
                  Navigator.pushAndRemoveUntil(
                      context,
                      generateScaleTransition(DashBoardScreen(
                        selectedPage: 0,
                      )),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
