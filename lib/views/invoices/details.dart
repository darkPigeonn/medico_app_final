import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:medico_app/models/user/invoices_model.dart';
import 'package:medico_app/utils/Typography.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:medico_app/utils/text_style.dart';
import 'package:medico_app/views/component/Button.dart';
import 'package:medico_app/views/component/showDialog.dart';
import 'package:medico_app/views/invoices/details_patient.dart';
import 'package:medico_app/views/payments/payment.dart';
import 'package:dospace/dospace.dart' as dospace;

class DetailsInvoice extends StatefulWidget {
  final InvoicesModel invoices;
  const DetailsInvoice({super.key, required this.invoices});

  @override
  State<DetailsInvoice> createState() => _DetailsInvoiceState();
}

class _DetailsInvoiceState extends State<DetailsInvoice> {
  File? image;
  bool statusUploadBukti = false;

  Future pickImageFromGalery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        print("Image is Empty");
        return;
      } else {
        final imageTemp = File(image.path);
        this.image = imageTemp;
        final imageTemp2 = image.name
            .replaceAll(RegExp(r"[^\s]+"), "INV-idPemesanan-tglPemesanan.jpg");
        print(imageTemp2);
        setState(() {
          statusUploadBukti = true;
        });
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
        print(imageTemp2);
        // ref.watch(statusUploadBukti.notifier).update((state) => true);
        setState(() {
          statusUploadBukti = true;
        });
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
                          style: h2(),
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
                            style: body1(),
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
                            style: body1(),
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

  Future<String?> uploadImage(String id, File photo) async {
    dospace.Spaces spaces = new dospace.Spaces(
      region: "sgp1",
      accessKey: "JCF6N7HWI4BIHYE5QLMD",
      secretKey: "7aGiKWmNa/hy78c9SrYHPkoPwhjoSl4YGVM9PHuFL/Y",
    );
    var _folderName = 'bukti_pembayaran';
    var _fileName = 'bukti_pembayaran-$id';
    var _extension = '.jpg';
    var _file = photo;
    var bucketName = 'imavistatic';
    dospace.Bucket bucket = spaces.bucket(bucketName);
    String? etag = await bucket.uploadFile(
      '$_folderName/$_fileName$_extension',
      _file,
      _extension,
      dospace.Permissions.public,
    );

    print('upload: $etag');
    await spaces.close();
    var _filePathDigitalOcean =
        "https://cdn.imavi.org/" + _folderName + '/' + _fileName + _extension;
    print(_filePathDigitalOcean);
    return _filePathDigitalOcean;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Invoice'),
      ),
      body: Container(
        margin: const EdgeInsets.all(3),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
//top bar invoices
                Column(
                  children: [
                    const Text(
                      'Detil Invoice',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.invoices.name!.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('d MMMM yyyy', 'id_ID')
                          .format(widget.invoices.invoiceDate!.date!),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.invoices.msList!.length,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        MsList data = widget.invoices.msList![index];
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                DetailsInvoicePatient(
                                                  detailPatient: data,
                                                )));
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(data
                                          .patientName!.capitalizeFirstofEach),
                                      subtitle: Text('Total : Rp ' +
                                          data.total!.intToFormatRupiah),
                                    ),
                                  ),
                                ),
                              ]),
                        );
                      }),
                ),
                const Divider(thickness: 1, height: 0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      Text(
                        "Bukti Pembayaran Produk",
                      )
                    ],
                  ),
                ),
                statusUploadBukti
                    ? Column(
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width - 32,
                                width: MediaQuery.of(context).size.width - 32,
                                decoration: BoxDecoration(
                                    color: n3,
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.contain,
                                  height:
                                      MediaQuery.of(context).size.width - 32,
                                  width: MediaQuery.of(context).size.width - 32,
                                ),
                              ),
                              Visibility(
                                visible: true,
                                child: GestureDetector(
                                  onTap: () {
                                    image!.delete();
                                    // ref
                                    //     .watch(statusUploadBukti.notifier)
                                    //     .update((state) => false);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.cancel,
                                      color: grey1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Visibility(
                            // visible: !ref.watch(isPembayaranSukses),
                            child: ButtonFill(
                              onPressed: () async {
                                //Upload Bukti Pembayaran Disini
                                showDialogLoading(context);
                                // String? a =
                                //     await uploadImage(widget.data.id, image!);
                                // Navigator.pop(context);

                                // if (a!.isEmpty) {
                                //   print("Failed To Upload");
                                // } else {
                                //   print(a);
                                //   await blocOrder.uploadBuktiPembayaran(
                                //       widget.data.id, a);
                                //   blocOrder.uploadPembayaran.listen((event) {
                                //     if (event == "Success") {
                                //       ref
                                //           .watch(isPembayaranSukses.notifier)
                                //           .update((state) => true);
                                //       showToast(
                                //           "Sukses Simpan Bukti Pembayaran");
                                //     } else {
                                //       showToast("Gagal Melakukan Pembayaran");
                                //     }
                                //   });
                                // }
                              },
                              size: MediaQuery.of(context).size.width - 32,
                              child: Text(
                                "Simpan Bukti Pembayaran Produk",
                                style: body1(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          showBtmModalOpsiUpload();
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width - 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: grey1),
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
                                style: body3(),
                              ),
                              // Text(
                              //   "(Format JPG, JPEG, PNG max 2 MB)",
                              //   style: body3(),
                              // ),
                            ],
                          ),
                        ),
                      ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40), // NEW
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PaymentPage()));
                  },
                  child: const Text(
                    'Unggah Bukti Pembayaran',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
