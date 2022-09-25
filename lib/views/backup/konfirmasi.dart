import 'package:flutter/material.dart';
import 'package:medico_app/models/user/respon_top_up.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/dashboard_screen.dart';
import 'package:medico_app/views/user/topup/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class KonfirmasiTopUp extends ConsumerWidget {
  const KonfirmasiTopUp(
      {Key? key,
      required this.url,
      required this.fromDashboard,
      required this.nominal})
      : super(key: key);

  final String url;
  final bool fromDashboard;
  final int nominal;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final status = watch(userProvider.notifier).getStatusTopUp(url);

    topUpViaWa() async {
      var whatsapp = "+6281293923";

      var whatsappURlandroid =
          "whatsapp://send?phone=" + whatsapp + "&text=Topup : ";

      await launch(whatsappURlandroid);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Status Top Up Saldo"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: status,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text(snapshot.error!.toString()),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final res = snapshot.data as ResponseTopUp;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(70),
                    child: res.success!
                        ? Image.asset('assets/success.jpg')
                        : Image.asset('assets/error.png'),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "${res.message}",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  res.success!
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {
                              if (fromDashboard) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  generateSlideTransition(DashBoardScreen(
                                    selectedPage: 0,
                                  )),
                                  (route) => false,
                                );
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Text("Lanjutkan"),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 30,
                  ),
                  !res.success! ? Text("Coba Lagi ?") : Container(),
                  !res.success!
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    generateSlideTransition(
                                      IndexTopUp(
                                        fromDashboard: fromDashboard,
                                        tagihanSaatIni:
                                            fromDashboard == true ? 0 : nominal,
                                      ),
                                    ),
                                  );
                                },
                                child: Text("Ya"),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Tidak"),
                              ),
                            )
                          ],
                        )
                      : Container(),
                  !res.success!
                      ? Text("Atau gunakan metode lain ?")
                      : Container(),
                  !res.success!
                      ? ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            topUpViaWa();
                          },
                          icon: Container(
                            height: 25,
                            child: Image.asset('assets/whatsapp.png'),
                          ),
                          label: Text("Hubungi Admin"),
                        )
                      : Container(),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
