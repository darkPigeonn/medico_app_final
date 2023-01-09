import 'package:flutter/material.dart';
import 'package:medico_app/models/reservation/loket_model.dart';
import 'package:medico_app/utils/const_color.dart';

import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/membership_badge.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/nominalTopUp.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/primary_txt_field_format.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/user/topup/status_top_up.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexTopUp extends StatefulWidget {
  const IndexTopUp({
    Key? key,
    required this.tagihanSaatIni,
    required this.fromDashboard,

    //FOR STEP 2
    this.loket,
    this.customerId,
    this.email,
  }) : super(key: key);

  final int tagihanSaatIni;
  final bool fromDashboard;

  //FOR STEP 2
  final Loket? loket;
  final String? customerId;
  final String? email;

  @override
  _IndexTopUpState createState() => _IndexTopUpState();
}

class _IndexTopUpState extends State<IndexTopUp> {
  bool isloading = true;

  int totalTagihan = 0;
  int saldo = 0;

  String membership = '';

  TextEditingController nominalController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

    initialData();
  }

  initialData() async {
    await getSaldo();

    if (widget.fromDashboard == false) {
      var tagihan = widget.tagihanSaatIni - saldo;

      if (tagihan > 0) {
        totalTagihan = tagihan;
      } else {
        totalTagihan = 0;
      }
    }

    setState(() {
      isloading = false;
    });
  }

  Future getSaldo() async {
    await context.read(userProvider.notifier).getDataProfile().then((dataUser) {
      saldo = dataUser.creditBalance!;
      membership = dataUser.realMembership!;
    }).catchError((onError) {
      messageSnackBar(context, onError['msg']);
    });

    setState(() {});
  }

  showDialogTopUp() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: PrimaryTextFieldFormat(
                    hintText: "Rp",
                    txtInputType: TextInputType.number,
                    controller: nominalController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFBff0f7b),
                    ),
                    child: Text(
                      "Selanjutnya",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future submitKonfirmasi(int nominal) async {
    setState(() {
      isloading = true;
    });

    await context.read(userProvider.notifier).topUp(nominal).then((value) {
      setState(() {
        isloading = false;
      });
      Navigator.pushReplacement(
          context,
          generateSlideTransition(
            TopUpScreen(
              data: value,
              fromDashboard: widget.fromDashboard,
              nominal: nominal,

              //for step 2
              loket: widget.loket,
              customerId: widget.customerId,
              email: widget.email,
            ),
          ),
          result: false);
    }).catchError((onError) {
      messageSnackBar(context, onError['msg']);
      setState(() {
        isloading = false;
      });
    });
  }

  void showDialogKonfirmasi(nominal) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Top Up"),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Jumlah Top Up"),
                  Text(
                    "Rp ${CurrencyFormat.convertToIdr(nominal, 2)}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: Icon(Icons.close_sharp),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      child: Text("Konfirmasi"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        submitKonfirmasi(nominal);
                      },
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        elevation: 0,
        backgroundColor: mBackgroundColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getSaldo();
        },
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: isloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: mColorCard,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: styleBoxShadow,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Top Up ",
                                style: mStyleTitleLight,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 30, right: 30),
                                child: Divider(
                                  color: mFillColor,
                                  height: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                decoration: BoxDecoration(
                                  color: mColorBadge,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    "Saldo : ${CurrencyFormat.convertToIdr(saldo, 2)}",
                                    style: mStyleTitleWhite,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: MembershipWidget(membership: membership),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        widget.fromDashboard == false
                            ? Container(
                                color: Color(0xFFFF0000),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tagihan saat ini",
                                          style: mStyleTitleWhite,
                                        ),
                                        Text(
                                          "Kekurangan",
                                          style: mStyleTitleWhite,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${CurrencyFormat.convertToIdr(widget.tagihanSaatIni, 2)}",
                                          style: mStyleTitleWhite,
                                        ),
                                        Text(
                                          "${CurrencyFormat.convertToIdr(totalTagihan, 2)}",
                                          style: mStyleTitleWhite,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: mColorCard,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: styleBoxShadow,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                width: double.infinity,
                                child: Text(
                                  "Jumlah  top up",
                                  style: TextStyle(
                                    color: mFillColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2),
                              PrimaryTextFieldFormat(
                                hintText: "Rp",
                                txtInputType: TextInputType.number,
                                controller: nominalController,
                                enabled: false,
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  "*minimum jumlah topup sesuai tagihan saat ini.",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: mFillColor),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              widget.fromDashboard == false
                                  ? Row(
                                      children: [
                                        NominalContainer(
                                          onTap: () {
                                            setState(() {
                                              nominalController =
                                                  TextEditingController(
                                                      text:
                                                          "${CurrencyFormat.convertToIdr(totalTagihan, 0)}");
                                            });
                                          },
                                          label:
                                              'Gunakan kekurangan biaya saat ini : ${CurrencyFormat.convertToIdr(totalTagihan, 2)}',
                                        ),
                                      ],
                                    )
                                  : Container(),
                              Row(
                                children: [
                                  NominalContainer(
                                    onTap: () {
                                      setState(() {
                                        nominalController = TextEditingController(
                                            text:
                                                "${CurrencyFormat.convertToIdr(100000, 0)}");
                                      });
                                    },
                                    label: 'Rp 100.000',
                                  ),
                                  NominalContainer(
                                    onTap: () {
                                      setState(() {
                                        nominalController = TextEditingController(
                                            text:
                                                "${CurrencyFormat.convertToIdr(200000, 0)}");
                                      });
                                    },
                                    label: 'Rp 200.000',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  NominalContainer(
                                    onTap: () {
                                      setState(() {
                                        nominalController = TextEditingController(
                                            text:
                                                "${CurrencyFormat.convertToIdr(500000, 0)}");
                                      });
                                    },
                                    label: 'Rp 500.000',
                                  ),
                                  NominalContainer(
                                    onTap: () {
                                      setState(() {
                                        nominalController = TextEditingController(
                                            text:
                                                "${CurrencyFormat.convertToIdr(1000000, 0)}");
                                      });
                                    },
                                    label: 'Rp 1000.000',
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(5),
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialogTopUp();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: mColorCardDark,
                                  ),
                                  child: Text("Masukan Jumlah Lainya"),
                                ),
                              ),
                              Container(
                                width: 150,
                                margin: EdgeInsets.all(5),
                                child: PrimaryButton(
                                  hint: "Selanjutnya",
                                  onTap: () {
                                    if (nominalController.text != '') {
                                      // convert to int
                                      int nominal = int.parse(nominalController
                                          .text
                                          .replaceAll('.', ''));

                                      if (nominal >= 10000) {
                                        // cek apakah topup dilakukan di reservasi atau dashboard
                                        if (widget.fromDashboard == false) {
                                          if (nominal >= totalTagihan) {
                                            showDialogKonfirmasi(nominal);
                                          } else {
                                            messageSnackBar(context,
                                                "minimum jumlah topup sesuai tagihan saat ini.");
                                          }
                                        } else {
                                          showDialogKonfirmasi(nominal);
                                        }
                                      } else {
                                        messageSnackBar(context,
                                            "minimum jumlah topup 10.000 rupiah.");
                                      }
                                    } else {
                                      messageSnackBar(
                                          context, "Masukan jumlah top up");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
