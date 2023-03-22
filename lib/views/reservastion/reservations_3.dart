import 'package:flutter/material.dart';
import 'package:medico_app/views/reservastion/reservations_4.dart';

import '../../utils/transition.dart';

class Reservations_3 extends StatefulWidget {
  const Reservations_3({super.key});

  @override
  State<Reservations_3> createState() => _ReservationsState_3();
}

class _ReservationsState_3 extends State<Reservations_3> {
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
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buat Reservasi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'Silahkan Pilih Tanggal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                  onPressed: () async {
                    final DateTime? selected = await showDatePicker(
                      context: context,
                      initialDate: beforeNow,
                      firstDate: beforeNow,
                      lastDate: DateTime(beforeNow.year + 5),
                    );
                    if (selected != null && selected != selectedDate) {
                      // checkTimeAvailable(selected);
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
                child: Text(
                  'Silahkan Pilih Jam Operasional',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 4,
              ),
            ],
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
                child: Text('Selanjutnya'),
                onPressed: () {
                  Navigator.push(
                      context,
                      generateSlideTransitionHorizontal(
                        Reservations_4(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
