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
        backgroundColor: mPrimary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            width: 305,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: mWhite,
              borderRadius: BorderRadius.circular(
                10,
              ),
              boxShadow: styleBoxShadow,
            ),
            child: Column(
              children: [
                DetailCard(value: widget.data.outletName!, label: 'Klinik'),
                DetailCard(
                    value: widget.data.subOutletName!, label: 'Sub-Klinik'),
                DetailCard(value: widget.data.patientName!, label: 'Pasien'),
                DetailCard(value: widget.data.patientName!, label: 'Pasien'),
                Container(
                  child: DetailCard(
                      value: formatDate(widget.data.reservationDate),
                      label: 'Tanggal'),
                ),
                Container(
                  margin: EdgeInsets.only(right: 40, left: 40),
                  child: Divider(
                    color: mBlack,
                  ),
                ),
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
                        child: Text(e.serviceName.toString()),
                      ),
                      Container(
                        child: Text("Rp " + e.amount.toString()),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showAlertDialog(context, widget.data.id.toString());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Batalkan'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      var signature = await ReservationService()
                          .getSignatureZoom(widget.data.id.toString());
                      print("signature");
                      print(signature);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Meeting2(
                            signature: signature,
                          ),
                        ),
                      );
                    },
                    child: Text('Masuk Ke Ruang Konsultasi'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
