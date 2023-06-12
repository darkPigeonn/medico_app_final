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
import 'package:medico_app/views/user/pets/detail_pet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user/patient_model.dart';
import '../notifikasi/notifikasi.dart';

class PetsSection extends StatefulWidget {
  const PetsSection({Key? key}) : super(key: key);

  @override
  _PetsSectionState createState() => _PetsSectionState();
}

class _PetsSectionState extends State<PetsSection> {
  List<PatientModel> pets = [];

  late UserModel user;

  bool isloading = true;

  Future<void> getDataProfile() async {
    bool isConnect = true;
    bool isconnected = true;
    if (isconnected) {
      user = UserModel();
      context.read(userProvider.notifier).getDataProfile().then((value) {
        setPets(value);
      }).catchError((onError) {
        messageSnackBar(context, onError['msg']);
      });
    } else {
      messageSnackBar(context, 'Tidak ada intenet');
    }
  }

  setPets(UserModel data) {
    setState(() {
      user = data;
      pets = user.pets!;
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataProfile();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                // Container(
                //   width: 60,
                //   child: Column(
                //     children: [
                //       MaterialButton(
                //         onPressed: () {
                //           // Navigator.push(context,
                //           //     MaterialPageRoute(builder: (context) => CreatePet()));
                //         },
                //         padding: EdgeInsets.all(10),
                //         color: Color.fromARGB(255, 255, 255, 255),
                //         textColor: Color.fromARGB(255, 0, 13, 194),
                //         child: Icon(
                //           Icons.add,
                //           size: 30,
                //         ),
                //         shape: CircleBorder(),
                //       ),
                //       // Text('Tambah')
                //     ],
                //   ),
                // ),
                Container(
                  width: 60,
                  child: Column(
                    children: [
                      pets[0].image == 'kosong'
                          ? MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPet(
                                              pet: pets[0],
                                            )));
                              },
                              padding: EdgeInsets.all(10),
                              color: Color.fromARGB(255, 255, 255, 255),
                              textColor: Color.fromARGB(255, 0, 13, 194),
                              child: Text(
                                pets[0].image.toString()[0].toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              shape: CircleBorder(),
                            )
                          : InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPet(
                                            pet: pets[0],
                                          ))),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(pets[0].image!),
                                radius: 25,
                              ),
                            )
                      // Text(pets[0].petName.toString())
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
