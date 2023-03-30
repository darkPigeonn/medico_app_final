import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:medico_app/models/outlet/outlet_model.dart';
import 'package:medico_app/models/outlet/sublist_model.dart';
import 'package:medico_app/models/reservation/loket_model.dart';
import 'package:medico_app/models/user/patient_model.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/services/reservation/master_service.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_button.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/reservastion/step_1.dart';
import 'package:medico_app/views/reservastion/step_2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../models/user/user_model.dart';

class CreateReservation extends StatefulWidget {
  const CreateReservation({Key? key}) : super(key: key);

  @override
  _CreateReservationState createState() => _CreateReservationState();
}

class _CreateReservationState extends State<CreateReservation> {
  bool isloading = true;
  List<OutletModel>? lokets;
  Loket selectedLoket = Loket();
  String hintLoket = 'Pilih Loket';
  late String customerId;
  late int saldo;
  late String email;
  List<Marker> myLoketLocation = [];

  // maps
  late GoogleMapController mapController;
  Set<Circle> circles = HashSet<Circle>();
  int idCircle = 1;
  double radius = 30;

  //medivet
  List<PatientModel> animals = [];
  List<PatientModel> _selectedAnimals = [];

  late SublistModel sublist;
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    if (!mounted) return;
    setState(() {
      mapController = controller;
    });
  }

  initialData() async {
    bool isconnected = await CheckConnectivity.checkConnection();

    if (isconnected) {
      await context.read(userProvider.notifier).getDataProfile().then((value) {
        setState(() {
          UserModel user = value;
          animals = user.pets!;
        });
      }).catchError((onError) {
        print('error gaes');
        messageSnackBar(context, onError['msg']);
      });

      await MasterService().getLokets().then((value) {
        lokets = value;
        sublist = lokets![0].subList![0];
      }).catchError((e) {
        messageSnackBar(context, e['msg']);
        lokets = [];
      });

      if (!mounted) return;
      setState(() {
        isloading = false;
      });
    } else {
      messageSnackBar(context, 'Tidak ada intenet');
    }
  }

  gotoLocation(Loket _selectedLoket) async {
    // index 0 = lat(split), index 1 = lng
    // lat nilainya minus

    if (_selectedLoket.coordinate!.length > 0) {
      var split = selectedLoket.coordinate![1].split(',');

      double lat = double.parse(_selectedLoket.coordinate![0]);
      double lng = double.parse(split[0]);

      setState(() {
        myLoketLocation = [];
        myLoketLocation.add(
          Marker(
            markerId: MarkerId(
              _selectedLoket.sId!,
            ),
            position: LatLng(lat, lng),
          ),
        );
        circles.clear();
        circles.add(
          Circle(
            circleId: CircleId(
              _selectedLoket.code!,
            ),
            center: LatLng(lat, lng),
            radius: 20,
            fillColor: Colors.redAccent.withOpacity(0.7),
            strokeColor: Colors.redAccent,
            strokeWidth: 3,
          ),
        );
      });
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(lat, lng),
          zoom: 18,
        )),
      );
    }
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    initialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          IconButton(
            onPressed: () {
              initialData();
            },
            icon: Icon(
              Icons.replay_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isloading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.all(15),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Buat Reservasi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Silahkan Pilih Hewan Kesayangan Anda',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: animals.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            title: Text(animals[index].petName!),
                            value: _selectedAnimals.contains(animals[index]),
                            onChanged: (value) {
                              if (value!) {
                                setState(() {
                                  _selectedAnimals.add(animals[index]);
                                });
                              } else {
                                setState(() {
                                  _selectedAnimals.remove(animals[index]);
                                });
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ElevatedButton(
              //   child: Text('Kembali'),
              //   onPressed: () {},
              // ),
              ElevatedButton(
                child: Text('Selanjutnya'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => CreateStep2(
                                selectedAnimals: _selectedAnimals,
                                sublist: sublist,
                              )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  //  SingleChildScrollView(
  //                     child: Container(
  //                       margin: EdgeInsets.all(20),
  //                       decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(10)),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text("Silahkan Pilih Klinik"),
  //                           Card(
  //                               child: InkWell(
  //                             onTap: () {
  //                               Navigator.push(
  //                                 context,
  //                                 generateScaleTransition(
  //                                   CreateStep2(
  //                                       customerId: customerId,
  //                                       email: email,
  //                                       loket: selectedLoket),
  //                                 ),
  //                               );
  //                             },
  //                             child: Container(
  //                                 width: MediaQuery.of(context).size.width,
  //                                 padding: EdgeInsets.symmetric(
  //                                     horizontal: 20, vertical: 10),
  //                                 child: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Text(
  //                                           'Poli Umum',
  //                                           style: GoogleFonts.alike(
  //                                             fontSize: 20,
  //                                           ),
  //                                         ),
  //                                         Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             Icon(
  //                                               Icons.access_time,
  //                                               size: 12,
  //                                             ),
  //                                             SizedBox(
  //                                               width: 2,
  //                                             ),
  //                                             Text(
  //                                               '08.00 - 16.00 WIB',
  //                                               style: GoogleFonts.alike(
  //                                                 fontSize: 11,
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     Text(
  //                                       'Adina - Klinik Utama',
  //                                       style: GoogleFonts.alike(
  //                                           fontSize: 12,
  //                                           color: Color.fromARGB(
  //                                               255, 202, 202, 202)),
  //                                     ),
  //                                   ],
  //                                 )),
  //                           )),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Align(
  //                       alignment: FractionalOffset.bottomCenter,
  //                       child: PrimaryButton2(
  //                         hint: "Lanjutkan",
  //                         onTap: () {
  //                           if (selectedLoket.sId != null) {
  //                             Navigator.push(
  //                               context,
  //                               generateScaleTransition(
  //                                 CreateStep2(
  //                                     customerId: customerId,
  //                                     email: email,
  //                                     loket: selectedLoket),
  //                               ),
  //                             );
  //                           } else {
  //                             messageSnackBar(
  //                                 context, "Silahkan pilih loket dulu.");
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                   ),