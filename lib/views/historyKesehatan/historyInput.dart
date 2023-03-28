import 'package:flutter/material.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/text_library.dart';
import 'package:medico_app/utils/text_style.dart';
import 'package:medico_app/views/historyKesehatan/history.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryInput extends StatefulWidget {
  HistoryInput({Key? key}) : super(key: key);

  @override
  State<HistoryInput> createState() => _HistoryInputState();
}

class _HistoryInputState extends State<HistoryInput> {
  static const title = "blood";
  static const unit = "blood";

  TextEditingController c_weight = TextEditingController();
  TextEditingController c_height = TextEditingController();
  TextEditingController c_oxygen = TextEditingController();
  TextEditingController c_suhu = TextEditingController();
  TextEditingController c_tensiSistole = TextEditingController();
  TextEditingController c_tensiDiastole = TextEditingController();
  TextEditingController c_tensiPulse = TextEditingController();
  TextEditingController c_kolestrol = TextEditingController();
  TextEditingController c_asamUrat = TextEditingController();
  TextEditingController c_glucose = TextEditingController();
  TextEditingController c_darahPuasa = TextEditingController();
  TextEditingController c_darah2Jam = TextEditingController();

  saveVital() async {
    final weight = c_weight.text.isNotEmpty ? c_weight.text.toString() : '0';
    final height = c_height.text.isNotEmpty ? c_height.text.toString() : '0';
    final oxygen = c_oxygen.text.isNotEmpty ? c_oxygen.text.toString() : '0';
    final suhu = c_suhu.text.isNotEmpty ? c_suhu.text.toString() : '0';
    final tensiSistole =
        c_tensiSistole.text.isNotEmpty ? c_tensiSistole.text.toString() : '0';
    final tensiDiastole =
        c_tensiDiastole.text.isNotEmpty ? c_tensiDiastole.text.toString() : '0';
    final tensiPulse =
        c_tensiPulse.text.isNotEmpty ? c_tensiPulse.text.toString() : '0';
    final kolestrol =
        c_kolestrol.text.isNotEmpty ? c_kolestrol.text.toString() : '0';
    final asamUrat =
        c_asamUrat.text.isNotEmpty ? c_asamUrat.text.toString() : '0';
    final glucose = c_glucose.text.isNotEmpty ? c_glucose.text.toString() : '0';
    final darahPuasa =
        c_darahPuasa.text.isNotEmpty ? c_darahPuasa.text.toString() : '0';
    final darah2Jam =
        c_darah2Jam.text.isNotEmpty ? c_darah2Jam.text.toString() : '0';

    var data = {
      "weight": int.parse(weight),
      "height": int.parse(height),
      "oxygen": int.parse(oxygen),
      "suhu": int.parse(suhu),
      "tensiSistole": int.parse(tensiSistole),
      "tensiDiastole": int.parse(tensiDiastole),
      "tensiPulse": int.parse(tensiPulse),
      "kolestrol": int.parse(kolestrol),
      "asamUrat": int.parse(asamUrat),
      "glucose": int.parse(glucose),
      "darahPuasa": int.parse(darahPuasa),
      "darah2Jam": int.parse(darah2Jam),
    };

    print(data);

    // await context
    //     .read(userProvider.notifier)
    //     .getDataProfile()
    //     .then((value) async {
    //   await context
    //       .read(userProvider.notifier)
    //       .createVital(value.id!, data)
    //       .then((value2) {
    //     messageSnackBarColor(context, value2['msg'], cSuccess);
    //     Navigator.pop(context);
    //   }).catchError((onError) {
    //     messageSnackBarColor(context, onError['msg'], cFail);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mPrimary,
        title: Text(
          'Input Data Kesehatan',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bodyWeight,
                style: form_titleContent,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_weight,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(sKg),
                    ),
                  ),
                  // hintText: bodyWeight,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                bodyHeight,
                style: form_titleContent,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_height,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(sMgDl),
                    ),
                  ),
                  // hintText: bodyHeight,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                bloodPleasure,
                style: form_titleContent,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_tensiSistole,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: sys,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(mmHg),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_tensiDiastole,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(mmHg),
                    ),
                  ),
                  hintText: dial,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_tensiPulse,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(s_min),
                    ),
                  ),
                  hintText: pulse,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                sp02,
                style: form_titleContent,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_oxygen,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(sPersen),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                totalCholesterol,
                style: form_titleContent,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_kolestrol,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(sMgDl),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                glukosa,
                style: form_titleContent,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_glucose,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(sMgDl),
                    ),
                  ),
                  hintText: gSewaktu,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_darahPuasa,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(sMgDl),
                    ),
                  ),
                  hintText: gPuasa,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_darah2Jam,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(sMgDl),
                    ),
                  ),
                  hintText: g2jpp,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                uricAcid,
                style: form_titleContent,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: c_asamUrat,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Text(sMgDl),
                    ),
                  ),
                  // hintText: uricAcid,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    saveVital();
                    // messageSnackBar(context, 'Data berhasil disimpan');
                    // Future.delayed(
                    //     Duration(seconds: 3),
                    //     () => Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => HistoryMedic())));
                  },
                  child: Text('Simpan'))
            ],
          ),
        ),
      )),
    );
  }
}
