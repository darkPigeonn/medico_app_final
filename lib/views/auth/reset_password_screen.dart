import 'package:flutter/material.dart';
import 'package:medico_app/providers/auth/auth_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/primary_txt_field.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/auth/otp_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController tlpnController;
  bool isloading = false;

  doReset() async {
    if (tlpnController.text.isEmpty) {
      messageSnackBar(context, "nomor telepon harus diisi!");
    }

    if (tlpnController.text.isNotEmpty) {
      setState(() {
        isloading = true;
      });

      await context
          .read(authProvider.notifier)
          .forgotPassword(tlpnController.text)
          .then((value) {
        Navigator.pushReplacement(
          context,
          generateSlideTransition(OtpScreen(
            phone: tlpnController.text,
            resetPassword: true,
          )),
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
    tlpnController = TextEditingController(text: '');
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
                            "Reset Password",
                            style: mStyleTitle,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Anda akan menerima kode OTP melalui whatsaap",
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
                          hintText: "Nomor Telepon",
                          txtInputType: TextInputType.phone,
                          icon: Icons.phone,
                          controller: tlpnController,
                        ),
                        isloading
                            ? Container(
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : Container(),
                        PrimaryButton(
                          margin: EdgeInsets.only(top: 40, bottom: 20.0),
                          hint: isloading
                              ? "Kirim Kode OTP..."
                              : "Kirim Kode OTP",
                          onTap: () {
                            if (!isloading) {
                              doReset();
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
