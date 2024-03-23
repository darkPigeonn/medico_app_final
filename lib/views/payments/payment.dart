import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  File? image;

  Future pickImageFromGalery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      } else {
        final imageTemp = File(image.path);
        this.image = imageTemp;
        final imageTemp2 = image.name
            .replaceAll(RegExp(r"[^\s]+"), "INV-idPemesanan-tglPemesanan.jpg");
        // print(imageTemp2);
        // ref.watch(statusUploadBukti.notifier).update((state) => true);
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) {
        print("Image is Empty");
        return;
      } else {
        final imageTemp = File(image.path);
        this.image = imageTemp;
        final imageTemp2 = image.name
            .replaceAll(RegExp(r"[^\s]+"), "INV-idPemesanan-tglPemesanan.jpg");
        // print(imageTemp2);
        // ref.watch(statusUploadBukti.notifier).update((state) => true);
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void showBtmModalOpsiUpload() {
    showModalBottomSheet<dynamic>(
      context: context,
      builder: (context) {
        return Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close_rounded,
                            size: 32,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Pilih Opsi Unggah",
                          // style: h2(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      pickImageFromCamera();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            color: Color.fromARGB(255, 80, 80, 80),
                            size: 32,
                          ),
                          SizedBox(width: 16),
                          Text(
                            "Kamera",
                            // style: body1(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 16,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      pickImageFromGalery();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Color.fromARGB(255, 80, 80, 80),
                            size: 32,
                          ),
                          SizedBox(width: 16),
                          Text(
                            "Galeri",
                            // style: body1(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showBtmModalOpsiUpload();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  padding: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                    color: Color.fromARGB(255, 247, 247, 247),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: Color.fromARGB(255, 80, 80, 80),
                      ),
                      Text(
                        "Unggah Bukti Pembayaran",
                        // style: body3(),
                      ),
                      Text(
                        "(Format JPG, JPEG, PNG max 2 MB)",
                        // style: body3(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40), // NEW
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PaymentPage()));
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
