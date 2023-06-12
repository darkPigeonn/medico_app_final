import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:medico_app/models/user/patient_model.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/views/user/pets/form_pet.dart';

import '../../../utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/request_util.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPet extends StatelessWidget {
  const DetailPet({super.key, required this.pet});

  final PatientModel pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormPet(
                                    pet: pet,
                                  )));
                    },
                    child: Text('Ubah'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final image = await await ImagePicker()
                          .getImage(source: ImageSource.camera);

                      if (image == null) return;

                      final imageTemporay = File(image.path);

                      uploadImages(imageTemporay, pet.id!).then((value) async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        String? token = sp.getString(keyPref);

                        // context.read(userProvider.notifier).storeDataProfile(
                        //     user,
                        //     token,d
                        //     nopol,
                        //     nama,
                        //     manufactureYear,
                        //     registrationYear,
                        //     image);
                      });
                    },
                    child: Hero(
                      tag: 'profilePicture',
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                )
                              ]),
                          padding: EdgeInsets.all(50),
                          child: pet.image == 'kosong'
                              ? Text(
                                  pet.petName.toString()[0].toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Image.network(pet.image!)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    pet.petName.toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    pet.species.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    getGender(pet.sex!),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    getHRDDate(pet.dob.toString()),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Riwayat Kunjungan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DD MM YYYY',
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
