import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medico_app/providers/auth/auth_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/primary_txt_field.dart';
import 'package:medico_app/utils/text_library.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/auth/login_screen.dart';
import 'package:medico_app/views/auth/otp_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';

import '../dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String dropdownValue = jenisKelamin.first;
  String? selectedMonth;

  late TextEditingController nikController,
      namaController,
      emailController,
      notlpController,
      passwordController,
      dobController,
      addressController,
      alergiController;
  bool aggrement = false;
  bool isloading = false;

  void doRegister() async {
    setState(() {
      isloading = true;
    });
    if (nikController.text.isEmpty) {
      messageSnackBar(context, "nik harus diisi!");
    }
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
    if (dobController.text.isEmpty) {
      messageSnackBar(context, "tanggal lahir harus diisi!");
    }
    if (addressController.text.isEmpty) {
      messageSnackBar(context, "alamat harus diisi!");
    }
    if (alergiController.text.isEmpty) {
      messageSnackBar(context, "alergi harus diisi!");
    }

    if (namaController.text.isNotEmpty &
        emailController.text.isNotEmpty &
        notlpController.text.isNotEmpty &
        passwordController.text.isNotEmpty &
        nikController.text.isNotEmpty &
        dobController.text.isNotEmpty &
        addressController.text.isNotEmpty &
        alergiController.text.isNotEmpty) {
      int sex = dropdownValue == 'Perempuan' ? 0 : 1;
      Map registran = {
        'nik': nikController.text,
        'name': namaController.text,
        'sex': sex,
        'dob': dobController.text,
        'address': addressController.text,
        'allergy': alergiController.text,
        'email': emailController.text,
        'phoneNumber': notlpController.text,
        'password': passwordController.text
      };

      await context
          .read(authProvider.notifier)
          .register(registran)
          .then((value) {
        messageSnackBarColor(context, 'Registrasi Berhasil', cSuccess);
        Navigator.pushReplacement(
            context, generateSlideTransition(DashBoardScreen()));
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
    nikController = TextEditingController(text: '');
    dobController = TextEditingController(text: '');
    addressController = TextEditingController(text: '');
    alergiController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'Buat Akun',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 90, child: Text('NIK')),
                    Text(' : '),
                    Expanded(
                      child: TextField(
                        controller: nikController,
                        onSubmitted: (String value) async {},
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 90, child: Text('Nama')),
                    Text(' : '),
                    Expanded(
                      child: TextField(
                        controller: namaController,
                        onSubmitted: (String value) async {},
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 90, child: Text('Jenis Kelamin')),
                    Text(' : '),
                    Expanded(
                        child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? value) {
                        setState(() {
                          print(value);
                          dropdownValue = value!;
                          print(dropdownValue);
                        });
                      },
                      items: jenisKelamin
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 90, child: Text('Tanggal Lahir')),
                    Text(' : '),
                    // Expanded(
                    //     child: TextField(
                    //   readOnly: true,
                    //   controller: dobController,
                    //   onTap: () async {
                    //     DateTime? pickedDate = await showDatePicker(
                    //       context: context,
                    //       initialDatePickerMode: DatePickerMode.year,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(1945),
                    //       lastDate: DateTime(2100),
                    //     );

                    //     if (pickedDate != null) {
                    //       String formatDate =
                    //           DateFormat('yyyy-MM-dd').format(pickedDate);

                    //       print(formatDate);
                    //       setState(() {
                    //         dobController.text = formatDate.toString();
                    //       });
                    //     }
                    //   },
                    // )),
                    Expanded(
                        child: Row(
                      children: [
                        DropdownButton(
                          isExpanded: false,
                          items: bulan.map((item) {
                            return new DropdownMenuItem(
                              child: Container(
                                width: 20,
                                child: new Text(
                                  item['label'],
                                ),
                              ),
                              value: item['value'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              // selectedLeaveType = value;
                            });
                          },
                          value: selectedMonth,
                          hint: Text('Tanggal'),
                          style: TextStyle(
                              color: Colors.black, decorationColor: Colors.red),
                        ),
                        DropdownButton(
                          isExpanded: false,
                          items: bulan.map((item) {
                            return new DropdownMenuItem(
                              child: Container(
                                width: 20,
                                child: new Text(
                                  item['label'],
                                ),
                              ),
                              value: item['value'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              // selectedLeaveType = value;
                            });
                          },
                          value: selectedMonth,
                          hint: Text('Bulan'),
                          style: TextStyle(
                              color: Colors.black, decorationColor: Colors.red),
                        ),
                        DropdownButton(
                          isExpanded: false,
                          items: bulan.map((item) {
                            return new DropdownMenuItem(
                              child: Container(
                                width: 20,
                                child: new Text(
                                  item['label'],
                                ),
                              ),
                              value: item['value'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              // selectedLeaveType = value;
                            });
                          },
                          value: selectedMonth,
                          hint: Text('Tahun'),
                          style: TextStyle(
                              color: Colors.black, decorationColor: Colors.red),
                        ),
                      ],
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 90, child: Text('Alamat')),
                    Text(' : '),
                    Expanded(
                      child: TextField(
                        controller: addressController,
                        onSubmitted: (String value) async {},
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(width: 90, child: Text('Alergi')),
                //     Text(' : '),
                //     Expanded(
                //       child: TextField(
                //         controller: alergiController,
                //         onSubmitted: (String value) async {},
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 90, child: Text('Email')),
                    Text(' : '),
                    Expanded(
                      child: TextField(
                        controller: emailController,
                        onSubmitted: (String value) async {},
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 90, child: Text('Telephone')),
                    Text(' : '),
                    Expanded(
                      child: TextField(
                        controller: notlpController,
                        onSubmitted: (String value) async {},
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 90, child: Text('Password')),
                    Text(' : '),
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        onSubmitted: (String value) async {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  hint: 'Daftar',
                  onTap: () async {
                    doRegister();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
