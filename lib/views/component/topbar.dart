import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/auth/auth_provider.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/membership_badge.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/auth/login_screen.dart';
import 'package:medico_app/views/user/add_vehicles.dart';
import 'package:medico_app/views/user/edit_vehicles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medico_app/utils/primary_txt_field.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notifikasi/notifikasi.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  Map<dynamic, dynamic> oriPreferences = {
    "one": "Bersih",
    "two": "Cepat",
    "three": "Murah",
  };

  List<String> preferences = ["Bersih", "Cepat", "Murah"];

  late TextEditingController namaController,
      emailController,
      notlpController,
      passwordController;

  late UserModel user;

  bool isloading = true;

  Future<void> getDataProfile() async {
    bool isConnect = true;
    bool isconnected = true;
    if (isconnected) {
      user = UserModel();
      namaController = TextEditingController(text: '');

      context.read(userProvider.notifier).getDataProfile().then((value) {
        setDataProfile(value);
      }).catchError((onError) {
        messageSnackBar(context, onError['msg']);
      });
      isloading = false;
    } else {
      messageSnackBar(context, 'Tidak ada intenet');
    }
  }

  void setPreferences() {
    oriPreferences['one'] = preferences[0];
    oriPreferences['two'] = preferences[1];
    oriPreferences['three'] = preferences[2];
  }

  setDataProfile(UserModel data) {
    setState(() {
      user = data;
      namaController = TextEditingController(text: user.name);
      emailController = TextEditingController(text: user.email);
      isloading = false;
    });
  }

  void logout() async {
    context.read(authProvider.notifier).logout().then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          generateSlideTransition(LoginScreen()),
          (route) => false,
        );
      } else {
        messageSnackBar(context, "Gagal Logout");
      }
    });
  }

  showAlertDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Continue"),
      style: ElevatedButton.styleFrom(
        primary: Colors.red[400],
      ),
      onPressed: () {
        delete(id);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hapus Kendaraan?"),
      content: Text("Apakah anda yakin untuk menghapus data kendaraan?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void delete(String id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString(keyPref);
    context.read(userProvider.notifier).deleteVehicle(id, token!).then((value) {
      messageSnackBar(context, value['msg']);

      getDataProfile();
    });
  }

  Future<String> getLink(context, file) async {
    var reference = FirebaseStorage.instance.ref().child("vehicles/$file");
    String link = await reference.getDownloadURL().catchError((onError) {
      return '';
    });

    return link;
  }

  getKey(int key) {
    if (key == 1) {
      return "one";
    } else if (key == 2) {
      return "two";
    } else {
      return "three";
    }
  }

  void _onReorder(oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex = newIndex - 1;
    }
    final item = preferences.removeAt(oldIndex);
    preferences.insert(newIndex, item);
  }

  @override
  void initState() {
    super.initState();
    getDataProfile();
  }

  @override
  Widget build(BuildContext context) {
    Color _color1 = Color(0xFF005288);
    Color _color2 = Color(0xFF37474f);

    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : namaController.text == ""
            ? Center(
                child: Text(
                  'Gagal mengambil data',
                  style: TextStyle(color: mWhite),
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Hero(
                              tag: 'profilePicture',
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: mPrimary,
                                child: Text(
                                  "${namaController.text[0].toUpperCase()}",
                                  style: TextStyle(
                                    color: mFillColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat Pagi !',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                namaController.text.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotifikasiPage()));
                          },
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
    // return Container(
    //   padding: EdgeInsets.all(20),
    //   child: Row(
    //     children: [
    //       GestureDetector(
    //         onTap: () {},
    //         child: Hero(
    //           tag: 'profilePicture',
    //           child: CircleAvatar(
    //             radius: 15.0,
    //             backgroundColor: mPrimary,
    //             child: Text(
    //               "${namaController.text[0]}",
    //               style: TextStyle(
    //                 color: mFillColor,
    //                 fontSize: 10,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         child: Container(
    //           padding: EdgeInsets.symmetric(horizontal: 16),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               // GestureDetector(
    //               //   onTap: () {},
    //               //   child: Text(
    //               //     namaController.text,
    //               //     style: TextStyle(
    //               //         color: _color2,
    //               //         fontWeight: FontWeight.bold,
    //               //         fontSize: 16),
    //               //     maxLines: 1,
    //               //     overflow: TextOverflow.ellipsis,
    //               //   ),
    //               // ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: 32),
    //         width: 1,
    //         height: 40,
    //         color: Colors.grey[300],
    //       ),
    //       GestureDetector(
    //         onDoubleTap: () {
    //           logout();
    //         },
    //         child: Text('Keluar',
    //             style: TextStyle(color: _color2, fontWeight: FontWeight.bold)),
    //       )
    //     ],
    //   ),
    // );
  }
}
