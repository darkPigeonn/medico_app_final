import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:medico_app/utils/text_style.dart';
import 'package:medico_app/views/auth/login_screen.dart';
import 'package:medico_app/views/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplash() async {
    var duration = new Duration(seconds: 1);
    Timer(
      duration,
      route,
    );
  }

  void route() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString(keyPref);

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, anotherAnimation) {
          return token == null ? LoginScreen() : DashBoardScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mPrimary,
        child: Center(
          child: Text(
            'MEDICO',
            style: title,
          ),
        ),
      ),
    );
  }
}
