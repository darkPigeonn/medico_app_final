import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/primary_txt_field.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:medico_app/views/dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditVehicle extends StatefulWidget {
  const EditVehicle({Key? key, this.user, this.vehicle}) : super(key: key);

  final UserModel? user;
  final Vehicles? vehicle;

  @override
  _EditVehicleState createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  late TextEditingController namaKController, nopolKController;

  DateTime _manufactureYear = DateTime.now();
  DateTime _registrationYear = DateTime.now();

  final _fireStorage = FirebaseStorage.instance;
  final image = ImagePicker();

  String fileName = '';
  XFile? pickedFile;

  late UserModel user;

  bool isloading = true;

  void getManuFactureYear() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Year"),
          content: Container(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              selectedDate: _manufactureYear,
              onChanged: (DateTime dateTime) {
                setState(() {
                  _manufactureYear = dateTime;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void getRegistrationYear() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Year"),
          content: Container(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              selectedDate: _registrationYear,
              onChanged: (DateTime dateTime) {
                setState(() {
                  _registrationYear = dateTime;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _uploadFoto() async {
    //request permission
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      pickedFile = await image.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        var file = File(pickedFile!.path);

        setState(() {
          fileName = file.uri.path.split('/').last;
        });
        await _fireStorage
            .ref()
            .child('vehicles/$fileName')
            .putFile(file)
            .then((value) {
          return value;
        });
        print(file);
      } else {
        print("no image selected");
      }
    } else {
      print("Provide permission");
    }
  }

  void onSubmit() async {
    if (namaKController.text == '') {
      messageSnackBar(context, "Nama kendaraan kosong!");
    } else if (nopolKController.text == '') {
      messageSnackBar(context, "Nopol belum dipilih");
    } else {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString(keyPref);
      context
          .read(userProvider.notifier)
          .storeDataProfile(
            user,
            token!,
            widget.vehicle!.id!,
            nopolKController.text,
            namaKController.text,
            _manufactureYear.year,
            _registrationYear.year,
            pickedFile == null ? widget.vehicle!.image! : fileName,
          )
          .then((value) {
        Navigator.pop(context);
      }).catchError((onError) {
        messageSnackBar(context, onError['msg']);
      });
    }
  }

  putImage(String file) async {
    var reference = FirebaseStorage.instance.ref().child("vehicles/$file");
    await reference.getDownloadURL().then((value) {
      fileName = value;
      isloading = false;
    }).catchError((onError) {
      fileName = '';
      isloading = false;
    });

    setState(() {});
  }

  void initialData() async {
    setState(() {
      putImage(widget.vehicle!.image!);
      namaKController = TextEditingController(text: widget.vehicle!.name);
      nopolKController = TextEditingController(text: widget.vehicle!.nopol);

      _manufactureYear = DateTime(widget.vehicle!.manufacturYear == null
          ? 1999
          : widget.vehicle!.manufacturYear!);
      _registrationYear = DateTime(widget.vehicle!.registrationYear == null
          ? 1999
          : widget.vehicle!.registrationYear!);
    });
  }

  @override
  void initState() {
    super.initState();
    user = widget.user!;
    initialData();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return DashBoardScreen(
                selectedPage: 3,
              );
            })),
          ),
        ),
        elevation: 0,
        backgroundColor: mBackgroundColor,
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: mColorCard,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: styleBoxShadow,
                ),
                child: Column(
                  children: [
                    Text(
                      "Edit Kendaraan",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: mFillColor,
                      ),
                    ),
                    PrimaryTextField(
                      hintText: "Nama",
                      txtInputType: TextInputType.text,
                      icon: Icons.bike_scooter,
                      controller: namaKController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryTextField(
                      hintText: "Nopol",
                      txtInputType: TextInputType.text,
                      icon: Icons.sim_card,
                      controller: nopolKController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Text(
                              "${_manufactureYear.year}",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                getManuFactureYear();
                              },
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Text(
                              "${_registrationYear.year}",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                getRegistrationYear();
                              },
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    pickedFile == null
                        ? InkWell(
                            onTap: () {
                              _uploadFoto();
                            },
                            child: fileName == ''
                                ? Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 120,
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Image.network(
                                      fileName,
                                      fit: BoxFit.cover,
                                    )),
                          )
                        : InkWell(
                            onTap: () {
                              _uploadFoto();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Image.file(
                                File(pickedFile!.path),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 130,
                      child: PrimaryButton(
                          hint: "Simpan",
                          onTap: () {
                            onSubmit();
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
