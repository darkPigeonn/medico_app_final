import 'package:flutter/material.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/log/saldo_log_screen.dart';
import 'package:medico_app/views/user/topup/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackupMainScreen extends StatefulWidget {
  const BackupMainScreen({Key? key}) : super(key: key);

  @override
  _BackupMainScreenState createState() => _BackupMainScreenState();
}

class _BackupMainScreenState extends State<BackupMainScreen> {
  UserModel dataUser = UserModel();
  late bool isloading;
  showDialogTopUp(int totalSaldo) {
    Navigator.push(
      context,
      generateSlideTransition(
        IndexTopUp(
          fromDashboard: true,
          tagihanSaatIni: 0,
        ),
      ),
    );
  }

  Future initialData() async {
    setState(() {
      isloading = true;
    });
    await context.read(userProvider.notifier).getDataProfile().then((value) {
      dataUser = value;
    }).catchError((onError) {
      messageSnackBar(context, onError['msg']);
    });

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    initialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notification_important_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            initialData();
          },
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            generateSlideTransition(
                              IndexLogSaldo(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.credit_card),
                                  Text(
                                    "Saldo",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  isloading == true
                                      ? CircularProgressIndicator()
                                      : Text(
                                          "${CurrencyFormat.convertToIdr(dataUser.creditBalance, 2)}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                              Row(
                                children: [Text("Tap to history")],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          showDialogTopUp(dataUser.creditBalance!);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Icon(Icons.add),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Top-up",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //new wudget
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
