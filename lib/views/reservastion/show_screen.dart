import 'package:flutter/material.dart';
import 'package:medico_app/providers/reservation/reservationData_provider%20.dart';
import 'package:medico_app/services/reservation/reservation_service.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/views/reservastion/step_4.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medico_app/models/reservation/reservation_model.dart';
import 'package:medico_app/providers/reservation/reservation_provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medico_app/views/room/meet.dart';

class ShowReservasi extends StatefulWidget {
  final ReservationDataModel data;
  const ShowReservasi({Key? key, required this.data}) : super(key: key);

  @override
  _ShowReservasiState createState() => _ShowReservasiState();
}

class _ShowReservasiState extends State<ShowReservasi> {
  formatDate(String? date) {
    if (date != null) {
      initializeDateFormatting();
      final DateTime newDate = DateTime.parse(date);
      final DateFormat format = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
      final String formatted = format.format(newDate);

      return formatted;
    }
  }

  onDelete(String id) async {
    context
        .read(reservationProvider.notifier)
        .cancelReservation(id)
        .then((value) {
      messageSnackBar(context, value['message']);
      context.refresh(reservationDataProvider.notifier).getReservation();
      Navigator.pop(context);
    }).catchError((onError) {
      messageSnackBar(context, onError['message']);
    });
  }

  showAlertDialog(BuildContext context, String id) {
    print(id);
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Ya"),
      style: ElevatedButton.styleFrom(
        primary: Colors.red[400],
      ),
      onPressed: () {
        onDelete(id);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Batal Reservasi?"),
      content: Text("Apakah anda yakin untuk membatalkan data reservasi?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ServicesReservationModel> services = widget.data.services!;
    print(widget.data);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
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
                        ...services.map(
                          (e) => Column(
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
                                formatDate(widget.data.reservationDate),
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
                        ),
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: mWhite,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'TOTAL',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp 50.000',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showAlertDialog(context, widget.data.id.toString());
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Batalkan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
