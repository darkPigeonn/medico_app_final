import 'package:flutter/material.dart';
import 'package:medico_app/providers/auth/auth_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/primary_txt_field.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/auth/login_screen.dart';
import 'package:medico_app/views/auth/otp_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController namaController,
      emailController,
      notlpController,
      passwordController;
  bool aggrement = false;
  bool isloading = false;

  void doRegister() async {
    setState(() {
      isloading = true;
    });
    if (namaController.text.isEmpty) {
      messageSnackBar(context, "nama harus diisi!");
    }

    if (emailController.text.isEmpty) {
      messageSnackBar(context, "email harus diisi!");
    }

    if (notlpController.text.isEmpty) {
      messageSnackBar(context, "nomor telepon harus diisi!");
    }

    if (passwordController.text.isEmpty) {
      messageSnackBar(context, "password harus diisi!");
    }

    if (namaController.text.isNotEmpty &
        emailController.text.isNotEmpty &
        notlpController.text.isNotEmpty &
        passwordController.text.isNotEmpty) {
      await context
          .read(authProvider.notifier)
          .register(namaController.text, emailController.text,
              notlpController.text, passwordController.text)
          .then((value) {
        Navigator.pushReplacement(
          context,
          generateSlideTransition(OtpScreen(phone: notlpController.text)),
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

    namaController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
    notlpController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /*
    ------------------------
    https://capekngoding.com
    ------------------------
    Starring:
    Name: Flutter Way
    Youtube: https: //www.youtube.com/c/TheFlutterWay/playlists?app=desktop
    ------------------------
    [1] Update pubspec.yaml
    flutter_svg:
    
    [2] Import
    import 'package:flutter_svg/svg.dart';
    ------------------------
    Code generation with snippets can be a good solution for you or it can kill you.
    A basic understanding of Dart and Flutter is required.
    Keep it in mind, Our snippet can't generate many files yet.
    So, all of our snippets are put in one file which is not best practice.
    You need to do the optimization yourself, and at least you are familiar with using Flutter.
    ------------------------
    */
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
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.network(
                  "https://capekngoding.com/uploads/62f680369803f_main_top.png",
                  width: 120,
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            "Sign Up".toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 8,
                                child: Image.asset('assets/signup.png'),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 16.0),
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
                                    cursorColor: const Color(0xFF6F35A5),
                                    onSaved: (email) {},
                                    decoration: const InputDecoration(
                                      hintText: 'Email',
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
                                      cursorColor: const Color(0xFF6F35A5),
                                      decoration: const InputDecoration(
                                        hintText: "Kata Sandi",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.lock),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0 / 2),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Daftar".toUpperCase()),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "Sudah punya akun ? ",
                                        style: TextStyle(color: mBlack),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return LoginScreen();
                                              },
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Login",
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
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: Container(
    //       margin: EdgeInsets.all(10),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(14),
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.grey,
    //             offset: Offset(0.0, 1.0), //(x,y)
    //             blurRadius: 6.0,
    //           ),
    //         ],
    //       ),
    //       child: IconButton(
    //         icon: Icon(Icons.arrow_back, color: Colors.black),
    //         onPressed: () => Navigator.of(context).pop(),
    //       ),
    //     ),
    //     elevation: 0,
    //     backgroundColor: mBackgroundColor,
    //   ),
    //   body: SingleChildScrollView(
    //     child: Container(
    //       color: mBackgroundColor,
    //       constraints: BoxConstraints(
    //         maxHeight: size.height,
    //         maxWidth: size.width,
    //       ),
    //       child: Column(
    //         children: [
    //           Expanded(
    //             flex: 5,
    //             child: Container(
    //               margin: EdgeInsets.fromLTRB(
    //                   35, MediaQuery.of(context).size.height * 0.1, 35, 35),
    //               child: ListView(
    //                 children: [
    //                   Center(
    //                     child: Text(
    //                       "Buat Akun",
    //                       style: mStyleTitle,
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 20,
    //                   ),
    //                   PrimaryTextField(
    //                     hintText: "Nama",
    //                     txtInputType: TextInputType.text,
    //                     icon: Icons.person,
    //                     controller: namaController,
    //                   ),
    //                   SizedBox(
    //                     height: 20,
    //                   ),
    //                   PrimaryTextField(
    //                     hintText: "E-mail",
    //                     txtInputType: TextInputType.emailAddress,
    //                     icon: Icons.email,
    //                     controller: emailController,
    //                   ),
    //                   SizedBox(
    //                     height: 20,
    //                   ),
    //                   PrimaryTextField(
    //                     hintText: "Nomor Telepon",
    //                     txtInputType: TextInputType.phone,
    //                     icon: Icons.phone,
    //                     controller: notlpController,
    //                   ),
    //                   SizedBox(
    //                     height: 20,
    //                   ),
    //                   PrimaryTextField(
    //                     hintText: "Password",
    //                     txtInputType: TextInputType.text,
    //                     icon: Icons.lock_outline,
    //                     controller: passwordController,
    //                     obsText: true,
    //                   ),
    //                   SizedBox(
    //                     height: 20,
    //                   ),
    //                   Row(
    //                     children: [
    //                       Checkbox(
    //                         activeColor: mThemeColor,
    //                         checkColor: mThemeColor,
    //                         shape: CircleBorder(),
    //                         value: this.aggrement,
    //                         onChanged: (bool? value) {
    //                           setState(() {
    //                             aggrement = value!;
    //                           });
    //                         },
    //                       ),
    //                       Flexible(
    //                         child: Text(
    //                           "Dengan melanjutkan, saya menyatakan setuju dengan persyaratan penggunaan (https://aplikasiku.com/syarat)",
    //                           style: TextStyle(color: mSubtitle, fontSize: 14),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   isloading
    //                       ? Container(
    //                           child: Center(
    //                             child: CircularProgressIndicator(),
    //                           ),
    //                         )
    //                       : Container(),
    //                   PrimaryButton(
    //                     margin: EdgeInsets.only(top: 10),
    //                     hint: isloading ? "Daftar..." : "Daftar",
    //                     onTap: () {
    //                       if (aggrement) {
    //                         if (!isloading) {
    //                           doRegister();
    //                         }
    //                       }
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           InkWell(
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //             child: Container(
    //               margin: EdgeInsets.only(bottom: 30),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Sudah memiliki account?",
    //                     style: TextStyle(color: mSubtitle, fontSize: 14),
    //                   ),
    //                   Text(
    //                     "Login",
    //                     style: TextStyle(color: mThemeColor, fontSize: 14),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
