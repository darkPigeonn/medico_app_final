import 'package:flutter/material.dart';
import 'package:medico_app/providers/auth/auth_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/primary_txt_field.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/auth/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoResetPasswordScreen extends StatefulWidget {
  const DoResetPasswordScreen({Key? key, required this.token})
      : super(key: key);

  final String token;

  @override
  _DoResetPasswordScreenState createState() => _DoResetPasswordScreenState();
}

class _DoResetPasswordScreenState extends State<DoResetPasswordScreen> {
  late TextEditingController passwordController, vpasswordController;
  bool isloading = false;

  doResetPassword() async {
    setState(() {
      isloading = true;
    });

    if (passwordController.text.isEmpty) {
      messageSnackBar(context, "password harus diisi!");
    }

    if (passwordController.text != vpasswordController.text) {
      messageSnackBar(context, "password tidak sama");
    }

    if (passwordController.text.isNotEmpty) {
      await context
          .read(authProvider.notifier)
          .storeResetPassword(
              passwordController.text, vpasswordController.text, widget.token)
          .then((value) {
        Navigator.pushReplacement(
          context,
          generateSlideTransition(LoginScreen()),
        );
      }).catchError((onError) {
        messageSnackBar(context, onError['msg']);
      });
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    passwordController = TextEditingController(text: '');
    vpasswordController = TextEditingController(text: '');
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
                            "Kata Sandi Baru",
                            style: mStyleTitle,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Silahkan membuat kata sandi baru anda",
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
                          hintText: "Password",
                          txtInputType: TextInputType.text,
                          icon: Icons.vpn_key,
                          controller: passwordController,
                          obsText: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PrimaryTextField(
                          hintText: "Verifikasi Password",
                          txtInputType: TextInputType.text,
                          icon: Icons.vpn_key,
                          controller: vpasswordController,
                          obsText: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isloading
                            ? Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : SizedBox(),
                        PrimaryButton(
                          margin: EdgeInsets.only(top: 40, bottom: 20.0),
                          hint: isloading ? "Simpan..." : "Simpan",
                          onTap: () {
                            if (!isloading) {
                              doResetPassword();
                            }
                          },
                        ),
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
