import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePet extends StatefulWidget {
  const CreatePet({super.key});

  @override
  State<CreatePet> createState() => _CreatePetState();
}

class _CreatePetState extends State<CreatePet> {
  late int _selectedDate;
  late int _selectedMonth;
  late int _selectedYear;

  String _selectedSex = 'Jantan';

  List genders = ['Jantan', 'Betina'];

  @override
  void initState() {
    super.initState();
    getCurrentDate();
  }

  getCurrentDate() {
    var currentDate = new DateTime.now();
    setState(() {
      _selectedDate = currentDate.day;
      _selectedMonth = currentDate.month;
      _selectedYear = currentDate.year;
    });
  }

  File? _imageFile;
  final picker = ImagePicker();
  File? _imagePreview;
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imagePreview = new File(pickedFile!.path);
    });
  }

  List<int> _daysInMonth = List<int>.generate(31, (i) => i + 1);
  List<int> _monthsInYear = List<int>.generate(12, (i) => i + 1);
  List<int> _years = List<int>.generate(100, (i) => DateTime.now().year - i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tambahkan'),
                    Text(
                      'Hewan peliharaan anda',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Nama Hewan',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nama Hewan',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 183, 183, 183)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 3, color: Color.fromARGB(255, 0, 202, 0)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Kategori Hewan',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Kategori Hewan',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 183, 183, 183)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 3, color: Color.fromARGB(255, 0, 202, 0)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Tanggal Lahir',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        // dropdown for day
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _selectedDate!,
                            onChanged: (value) {
                              setState(() {
                                _selectedDate = value!;
                              });
                            },
                            items: _daysInMonth.map((day) {
                              return DropdownMenuItem<int>(
                                value: day,
                                child: Text(day.toString()),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintText: 'Day',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 183, 183, 183)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        // dropdown for month
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _selectedMonth,
                            onChanged: (value) {
                              setState(() {
                                _selectedMonth = value!;
                              });
                            },
                            items: _monthsInYear.map((month) {
                              return DropdownMenuItem<int>(
                                value: month,
                                child: Text(month.toString()),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintText: 'Month',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 183, 183, 183)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        // dropdown for year
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _selectedYear,
                            onChanged: (value) {
                              setState(() {
                                _selectedYear = value!;
                              });
                            },
                            items: _years.map((year) {
                              return DropdownMenuItem<int>(
                                value: year,
                                child: Text(year.toString()),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintText: 'Year',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 183, 183, 183)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Jenis Kelamin',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedSex,
                      onChanged: (value) {
                        setState(() {
                          _selectedSex = value!;
                        });
                      },
                      items: genders.map((year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: 'Year',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 183, 183, 183)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: _imagePreview != null
                          ? Image.file(
                              _imagePreview!,
                              width: 300,
                              height: 300,
                            )
                          : ElevatedButton(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 50,
                              ),
                              onPressed: pickImage,
                            ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Simpan'),
              ),
            )
          ],
        ),
      )),
    );
  }
}
