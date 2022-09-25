import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:medico_app/providers/auth/auth_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/primary_txt_field.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/auth/do_reset_password_screen.dart';
import 'package:medico_app/views/dashboard_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final bool? resetPassword;
  final bool verifyFromLogin;
  const OtpScreen(
      {Key? key,
      required this.phone,
      this.resetPassword,
      this.verifyFromLogin = false})
      : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController otpScontroller;

  late CountdownTimerController timeController;

  // 120
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  int maxRequestOtp = 1;

  bool disableRequestOtp = true;
  bool isloading = false;

  void doVerifyOtp() async {
    if (otpScontroller.text.isEmpty) {
      messageSnackBar(context, "otp harus diisi!");
    }
    setState(() {
      isloading = true;
    });
    if (otpScontroller.text.isNotEmpty) {
      if (widget.resetPassword != null && widget.resetPassword == true) {
        await context
            .read(authProvider.notifier)
            .verifyForgotPassword(widget.phone, otpScontroller.text)
            .then((value) {
          Navigator.pushReplacement(
            context,
            generateSlideTransition(
                DoResetPasswordScreen(token: value['token'])),
          );
        }).catchError((onError) {
          messageSnackBar(context, onError['msg']);
        });
      } else {
        context
            .read(authProvider.notifier)
            .verifyOtp(widget.phone, otpScontroller.text)
            .then((value) {
          Navigator.pushReplacement(
            context,
            generateSlideTransition(DashBoardScreen()),
          );
        }).catchError((onError) {
          messageSnackBar(context, onError['msg']);
        });
      }
    }
    setState(() {
      isloading = false;
    });
  }

  void doResendOtp() async {
    if (maxRequestOtp <= 5) {
      context.read(authProvider.notifier).resendOtp(widget.phone).then((value) {
        messageSnackBar(context, value['msg']);
      }).catchError((onError) {
        messageSnackBar(context, onError['msg']);
      });

      setState(() {
        disableRequestOtp = true;
        // 120
        endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
        maxRequestOtp += 1;
        timeController =
            CountdownTimerController(endTime: endTime, onEnd: onEnd);
      });
    } else {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setBool('limit_request_otp', true);
      setState(() {
        disableRequestOtp = true;
      });
    }
  }

  openwhatsapp() async {
    var whatsapp = "6281234567890";

    var whatsappURlandroid =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";

    await launch(whatsappURlandroid);
  }

  void onEnd() {
    if (maxRequestOtp <= 5) {
      setState(() {
        disableRequestOtp = false;
      });
    }

    timeController.disposeTimer();
  }

  onStart() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var isLimit = sp.getBool('limit_request_otp');
    if (isLimit == true) {
      setState(() {
        maxRequestOtp = 5;
      });
    } else {
      if (widget.verifyFromLogin) {
        doResendOtp();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    timeController = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    otpScontroller = TextEditingController(text: '');
    onStart();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: SingleChildScrollView(
        child: Container(
          color: mBackgroundColor,
          constraints: BoxConstraints(
            maxHeight: size.height,
            maxWidth: size.width,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      35, MediaQuery.of(context).size.height * 0.1, 35, 35),
                  child: Center(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Text(
                            "Verifikasi Kode",
                            style: mStyleTitle,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Masukan kode yang diterima di Whatshaap",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: mSubtitle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        PrimaryTextField(
                          hintText: "Kode OTP",
                          txtInputType: TextInputType.numberWithOptions(),
                          icon: Icons.format_list_numbered,
                          controller: otpScontroller,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CountdownTimer(
                          controller: timeController,
                          onEnd: onEnd,
                          endTime: endTime,
                          endWidget: Container(),
                        ),
                        isloading
                            ? Container(
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : Container(),
                        PrimaryButton(
                          margin: EdgeInsets.only(top: 40, bottom: 20.0),
                          hint: isloading ? "Submiting...." : "Submit",
                          onTap: () {
                            if (!isloading) {
                              doVerifyOtp();
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: InkWell(
                                onTap: () {
                                  if (!disableRequestOtp &&
                                      maxRequestOtp <= 5) {
                                    doResendOtp();
                                  }
                                },
                                child: Text(
                                  "Kirim Ulang OTP",
                                  style: TextStyle(
                                    color: mThemeColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        maxRequestOtp > 5
                            ? Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.amber[50],
                                    borderRadius: BorderRadius.circular(10)),
                                width: double.infinity,
                                height: 100,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(4),
                                      child: Text(
                                          "Maksimal 5 x request OTP, silahkan Whatsapp ke nomor 6281234567890"),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          openwhatsapp();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                        ),
                                        child: Text("Helpdesk WA"))
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
