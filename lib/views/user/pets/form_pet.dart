import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:medico_app/models/user/patient_model.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/const_color.dart';
import '../../../utils/message.dart';

class FormPet extends StatefulWidget {
  const FormPet({super.key, required this.pet});

  final PatientModel pet;
  @override
  State<FormPet> createState() => _FormPetState();
}

class _FormPetState extends State<FormPet> {
  late TextEditingController name, species, dob, gender;
  String imageUrl = '';

  File? _imagePreview;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var date = DateTime.parse(widget.pet.dob!);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    name = TextEditingController(text: widget.pet.petName);
    species = TextEditingController(text: widget.pet.species);
    dob = TextEditingController(text: formattedDate);
    gender = TextEditingController(text: widget.pet.sex.toString());
    imageUrl = widget.pet.image!;
  }

  uploadImg() async {
    final image =
        await await ImagePicker().getImage(source: ImageSource.camera);

    if (image == null) return;

    final imageTemporay = File(image.path);

    uploadImages(imageTemporay, widget.pet.id!).then((value) async {
      setState(() {
        imageUrl = value;
      });
    });
    setState(() {
      _imagePreview = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                          icon: Icon(Icons.arrow_back)),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Data Hewan',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Nama',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: mPrimary,
                        controller: name,
                        decoration: const InputDecoration(
                            hintText: "Nama Hewan",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Spesies Hewan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: mPrimary,
                        controller: species,
                        decoration: const InputDecoration(
                            hintText: "Spesies Hewan",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Tanggal Lahir',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: mPrimary,
                        controller: dob,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              dob.text =
                                  formattedDate; //set foratted date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "Tanggal Lahir Hewan",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Jenis Kelamin',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: mPrimary,
                        controller: name,
                        decoration: const InputDecoration(
                            hintText: "Jenis Kelamin Hewan",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Gambar Hewan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      imageUrl == 'kosong'
                          ? _imagePreview == null
                              ? Container()
                              : Center(
                                  child: Image.file(
                                    _imagePreview!,
                                    scale: 5,
                                  ),
                                )
                          : imageUrl.toString().contains('https')
                              ? Image.network(imageUrl)
                              : Image.file(_imagePreview!),
                      ElevatedButton(
                          onPressed: () {
                            uploadImg();
                          },
                          child: Text('Unggah Gambar')),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Map dataSend = {
                              'name': name.text,
                              'species': species.text,
                              'dob': dob.text,
                              'sex': gender.text,
                              'image': imageUrl
                            };

                            context
                                .read(userProvider.notifier)
                                .storeDataPatient(dataSend, widget.pet.id!)
                                .then((value) {
                              messageSnackBar(context, 'Sukses');
                            });
                          },
                          child: Text('Simpan'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
