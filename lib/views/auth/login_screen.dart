import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:medico_app/providers/auth/auth_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/primary_txt_field.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/auth/otp_screen.dart';
import 'package:medico_app/views/auth/register_screen.dart';
import 'package:medico_app/views/auth/reset_password_screen.dart';
import 'package:medico_app/views/dashboard_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController tlpnController, passwordController;
  late CountdownTimerController timeController;
  int? endTime;

  bool doLoginButton = true;
  bool isloading = false;

  doLogin() async {
    setState(() {
      isloading = true;
    });
    if (tlpnController.text.isEmpty) {
      messageSnackBar(context, "email harus diisi!");
    }

    if (passwordController.text.isEmpty) {
      messageSnackBar(context, "password harus diisi!");
    }
    if (tlpnController.text.isNotEmpty & passwordController.text.isNotEmpty) {
      await context
          .read(authProvider.notifier)
          .login(tlpnController.text, passwordController.text)
          .then((value) {
        Navigator.pushReplacement(
            context, generateSlideTransition(DashBoardScreen()));
      }).catchError((onError) {
        if (onError['msg'] == "Phone is not Verified") {
          Navigator.push(
            context,
            generateSlideTransition(OtpScreen(
              phone: tlpnController.text,
              verifyFromLogin: true,
            )),
          );
        } else {
          getStatusLimit();
        }
        messageSnackBar(context, onError['msg']);
      });
    }

    setState(() {
      isloading = false;
    });
  }

  void getStatusLimit() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getInt('limit_login') == 5) {
      setState(() {
        doLoginButton = true;
      });
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
      timeController =
          CountdownTimerController(endTime: endTime!, onEnd: onEnd);
    }

    if (sp.getInt('limit_login') == 10) {
      setState(() {
        doLoginButton = false;
      });
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 1800;
      timeController =
          CountdownTimerController(endTime: endTime!, onEnd: onEnd);
    }
  }

  void onEnd() {
    timeController.disposeTimer();
    setState(() {
      doLoginButton = true;
    });
  }

  @override
  void initState() {
    super.initState();
    tlpnController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    getStatusLimit();
    if (endTime != null) {
      timeController =
          CountdownTimerController(endTime: endTime!, onEnd: onEnd);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Theme(
      data: ThemeData(
        primaryColor: mPrimary,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: mPrimary,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color.fromARGB(255, 228, 228, 228),
          iconColor: mPrimary,
          prefixIconColor: mPrimary,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          const Text(
                            "MEDICO",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 16.0 * 2),
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 8,
                                child: Image.asset('assets/login.png'),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 16.0 * 2),
                        ],
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 8,
                            child: Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    cursorColor: mPrimary,
                                    controller: tlpnController,
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(Icons.person),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      cursorColor: mPrimary,
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                        hintText: "Kata sandi",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.lock),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  isloading
                                      ? Container(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()))
                                      : SizedBox(),
                                  Hero(
                                    tag: "login_btn",
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (doLoginButton) {
                                          if (!isloading) {
                                            doLogin();
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Login".toUpperCase(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "Tidak punya akun ? ",
                                        style: TextStyle(color: mBlack),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return RegisterScreen();
                                              },
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Daftar",
                                          style: TextStyle(
                                            color: mPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
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
