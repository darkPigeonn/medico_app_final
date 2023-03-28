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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    bool isconnected = await CheckConnectivity.checkConnection();

    if (isconnected) {
      user = UserModel();
      namaController = TextEditingController(text: '');
      emailController = TextEditingController(text: '');
      notlpController = TextEditingController(text: '');
      passwordController = TextEditingController(text: '');

      context.read(userProvider.notifier).getDataProfile().then((value) {
        setDataProfile(value);
      }).catchError((onError) {
        messageSnackBar(context, onError['msg']);
      });
    } else {
      messageSnackBar(context, 'Tidak ada intenet');
    }
  }

  void setPreferences() {
    oriPreferences['one'] = preferences[0];
    oriPreferences['two'] = preferences[1];
    oriPreferences['three'] = preferences[2];
  }

  Future<void> updateDataProfile() async {
    setState(() {
      isloading = true;
    });

    if (passwordController.text != '') {
      setPreferences();
      // await context
      //     .read(userProvider.notifier)
      //     .updateProfile(user.id!, namaController.text, emailController.text,
      //         notlpController.text, passwordController.text, oriPreferences)
      //     .then((value) {
      //   messageSnackBar(context, value['msg']);
      // }).catchError((onError) {
      //   messageSnackBar(context, onError['msg']);
      // });
    } else {
      messageSnackBar(context, "Password salah");
    }

    setState(() {
      isloading = false;
    });
  }

  setDataProfile(UserModel data) {
    setState(() {
      user = data;
      namaController = TextEditingController(text: user.name);
      emailController = TextEditingController(text: user.email);

      // // passwordController = TextEditingController(text: '');
      // if (data.preferensi!.one != "") {
      //   // old
      //   // preferences['one'] = data.preferensi!.one;
      //   // preferences['two'] = data.preferensi!.two;
      //   // preferences['three'] = data.preferensi!.three;

      //   // new
      //   preferences[0] = data.preferensi!.one!;
      //   preferences[1] = data.preferensi!.two!;
      //   preferences[2] = data.preferensi!.three!;
      // }

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

  // void _onReorder(oldIndex, newIndex) {
  //   if (newIndex > oldIndex) {
  //     newIndex = newIndex - 1;
  //   }

  //   var oldData = preferences[getKey(oldIndex + 1)];
  //   var newData = preferences[getKey(newIndex + 1)];

  //   preferences[getKey(oldIndex + 1)] = newData!;
  //   preferences[getKey(newIndex + 1)] = oldData!;
  // }

  @override
  void initState() {
    super.initState();
    getDataProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              getDataProfile();
            },
            icon: Icon(
              Icons.replay_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 70.0,
                            backgroundColor: mPrimary,
                            child: Text(
                              "${namaController.text[0]}",
                              style: TextStyle(
                                color: mFillColor,
                                fontSize: 43,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            namaController.text,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PrimaryTextField(
                            hintText: "Nama",
                            txtInputType: TextInputType.text,
                            icon: Icons.person,
                            controller: namaController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PrimaryTextField(
                            hintText: "E-mail",
                            txtInputType: TextInputType.emailAddress,
                            icon: Icons.email,
                            controller: emailController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PrimaryTextField(
                            hintText: "Password",
                            txtInputType: TextInputType.text,
                            icon: Icons.vpn_key,
                            controller: passwordController,
                            obsText: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PrimaryButton(
                            hint: isloading == true ? "Simpan..." : "Simpan",
                            onTap: () {
                              if (!isloading) {
                                updateDataProfile();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
