import 'package:flutter/material.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/text_library.dart';
import 'package:medico_app/utils/text_style.dart';
import 'package:medico_app/views/historyKesehatan/history.dart';
import 'package:simple_moment/simple_moment.dart';

class HistoryDetail extends StatelessWidget {
  const HistoryDetail({Key? key, required this.dataDetail}) : super(key: key);

  final Vital dataDetail;
  @override
  Widget build(BuildContext context) {
    List tekananDarah = [
      {
        'value': dataDetail.tensiSistole.toString() +
            ' / ' +
            dataDetail.tensiDiastole.toString(),
        'satuan': mmHg,
      }
    ];
    List detakJantung = [
      {
        'value': dataDetail.tensiPulse.toString(),
        'satuan': sBpm,
      }
    ];
    List saturasi = [
      {
        'value': dataDetail.oxygen.toString(),
        'satuan': sPersen,
      },
    ];
    List kolestrol = [
      {
        'value': dataDetail.kolestrol.toString(),
        'satuan': sMgDl,
      },
    ];
    List glukosPuasa = [
      {
        'value': dataDetail.darahPuasa.toString(),
        'satuan': sMgDl,
      },
    ];
    List glukos2jpp = [
      {
        'value': dataDetail.darah2Jam.toString(),
        'satuan': sMgDl,
      },
    ];
    List glukosSewaktu = [
      {
        'value': dataDetail.glucose.toString(),
        'satuan': sMgDl,
      },
    ];

    List asamUrat = [
      {
        'value': dataDetail.asamUrat.toString(),
        'satuan': sMgDl,
      },
    ];

    List tinggiBadan = [
      {
        'value': dataDetail.height.toString(),
        'satuan': sCm,
      }
    ];
    List beratBadan = [
      {
        'value': dataDetail.weight.toString(),
        'satuan': sKg,
      }
    ];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mPrimary,
        title: Text('Detail'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              Moment.parse(dataDetail.createdAt.toString())
                  .format('dd MMMM yyyy'),
              style: titleSectionLanding,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: mWhite,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 224, 224, 224),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              children: [
                dataVital(
                    size: size, title: bloodPleasure, content: tekananDarah),
                Divider(),
                dataVital(
                  size: size,
                  title: hr,
                  content: detakJantung,
                ),
                Divider(),
                dataVital(
                  size: size,
                  title: sp02,
                  content: saturasi,
                ),
                Divider(),
                dataVital(
                    size: size, title: totalCholesterol, content: kolestrol),
                Divider(),
                dataVital(size: size, title: gSewaktu, content: glukosSewaktu),
                dataVital(size: size, title: gPuasa, content: glukosPuasa),
                dataVital(size: size, title: g2jpp, content: glukos2jpp),
                Divider(),
                dataVital(size: size, title: uricAcid, content: asamUrat),
                Divider(),
                dataVital(size: size, title: bodyWeight, content: beratBadan),
                dataVital(size: size, title: bodyHeight, content: tinggiBadan),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
