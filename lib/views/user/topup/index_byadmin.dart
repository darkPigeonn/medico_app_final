import 'package:flutter/material.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/membership_badge.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexTopUpByAdmin extends StatefulWidget {
  const IndexTopUpByAdmin({
    Key? key,
    required this.tagihanSaatIni,
    required this.fromDashboard,
  }) : super(key: key);

  final int tagihanSaatIni;
  final bool fromDashboard;

  @override
  _IndexTopUpByAdminState createState() => _IndexTopUpByAdminState();
}

class _IndexTopUpByAdminState extends State<IndexTopUpByAdmin> {
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

  whatsapp() async {
    var whatsapp = "+6281293923";

    var whatsappURlandroid =
        "whatsapp://send?phone=" + whatsapp + "&text=Topup : ";

    await launch(whatsappURlandroid);
  }

  Future<void> call() async {
    String url = "tel:0597924917";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
      // saldo = dataUser.creditBalance!;
      // membership = dataUser.realMembership!;
    }).catchError((onError) {
      messageSnackBar(context, onError['msg']);
    });

    setState(() {});
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
                          margin: EdgeInsets.only(bottom: 30),
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
                              //input topup

                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "Hubungi Admin",
                                    style: TextStyle(
                                      color: mFillColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  call();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFBE8B0A),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Color(0xFFFFB909),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "Telepon Admin",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: mFillColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  whatsapp();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF49B508),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/wa.png'),
                                          SizedBox(width: 8),
                                          Text(
                                            "Whatsapp Admin",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: mFillColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 39,
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 3,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "Sudah mendapatkan konfirmasi topup sukses dari Admin Kilap? ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                margin: EdgeInsets.all(5),
                                child: PrimaryButton(
                                  hint: "Cek Saldo Sekarang",
                                  onTap: () {
                                    Navigator.pop(context);
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
