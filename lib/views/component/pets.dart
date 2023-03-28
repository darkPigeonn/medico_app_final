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

import '../../models/user/patient_model.dart';
import '../notifikasi/notifikasi.dart';

class PetsSection extends StatefulWidget {
  const PetsSection({Key? key}) : super(key: key);

  @override
  _PetsSectionState createState() => _PetsSectionState();
}

class _PetsSectionState extends State<PetsSection> {
  late List<PatientModel> pets;

  late UserModel user;

  bool isloading = true;

  Future<void> getDataProfile() async {
    bool isconnected = await CheckConnectivity.checkConnection();
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
    return Container(
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
          Container(
            width: 60,
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => CreatePet()));
                  },
                  color: Color.fromARGB(255, 255, 255, 255),
                  textColor: Color.fromARGB(255, 0, 13, 194),
                  child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                  shape: CircleBorder(),
                ),
                Text('Tambah')
              ],
            ),
          ),
          Container(
            width: 60,
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => CreatePet()));
                  },
                  color: Color.fromARGB(255, 255, 255, 255),
                  textColor: Color.fromARGB(255, 0, 13, 194),
                  child: Text(
                    pets[0].petName.toString()[0].toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  shape: CircleBorder(),
                ),
                Text(pets[0].petName.toString())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
