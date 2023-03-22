import 'package:flutter/material.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/providers/reservation/reservationData_provider%20.dart';
import 'package:medico_app/providers/reservation/reservation_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/loading.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/log/reservasi_log_screen.dart';
import 'package:medico_app/views/reservastion/reservations_2.dart';
import 'package:medico_app/views/reservastion/show_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class IndexReservation extends StatefulWidget {
  const IndexReservation({Key? key}) : super(key: key);

  @override
  _IndexReservationState createState() => _IndexReservationState();
}

class _IndexReservationState extends State<IndexReservation> {
  List<Vehicles> vehicles = [];

  bool isloading = true;

  formatDate(String? date) {
    if (date != null) {
      initializeDateFormatting();
      final DateTime newDate = DateTime.parse(date);
      final DateFormat format = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
      final String formatted = format.format(newDate);

      return formatted;
    }
  }

  formatStatus(String? data) {
    if (data != null) {
      print(data.toString());
      String status = '';
      switch (data) {
        case '0':
          status = 'Menunggu';
          break;
        case '70':
          status = 'Tersejui';
          break;
        default:
          status = 'Ditolak';
      }
      return status;
    }
  }

  initialData() async {
    bool isconnected = await CheckConnectivity.checkConnection();

    if (isconnected) {
      setState(() {
        isloading = false;
      });
      controller = ScrollController()..addListener(_scrollListener);
      context.refresh(reservationDataProvider.notifier).getReservation();
    } else {
      messageSnackBar(context, 'Tidak ada intenet');
    }
  }

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // initialData();
  }

  List<String> _selectedAnimals = [];

  List<String> _animals = [
    'Anjing',
    'Kucing',
    'Hamster',
    'Kelinci',
    'Ikan',
    'Burung',
    'Ular',
    'Kuda',
  ];

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       generateSlideTransition(
          //         IndexLogReservasi(),
          //       ),
          //     );
          //   },
          //   icon: Icon(
          //     Icons.list,
          //     color: Colors.black,
          //   ),
          // ),
          IconButton(
            onPressed: () {
              initialData();
            },
            icon: Icon(
              Icons.replay_outlined,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
      // body: RefreshIndicator(
      //   onRefresh: () async {
      //     context.refresh(reservationProvider).getReservation();
      //   },
      //   child: isloading == true
      //       ? Container(
      //           child: Center(
      //             child: CircularProgressIndicator(),
      //           ),
      //         )
      //       : Column(
      //           children: [
      //             Expanded(
      //               child: Consumer(
      //                 builder: (context, watch, child) {
      //                   final reservationData = watch(reservationDataProvider);
      //                   return reservationData.when(
      //                     data: (data) {
      //                       if (data.length == 0) {
      //                         return Center(
      //                           child: Text("Tidak Ada Data"),
      //                         );
      //                       }
      //                       return ListView.builder(
      //                         controller: controller,
      //                         itemCount: data.length,
      //                         itemBuilder: (context, index) {
      //                           return Column(
      //                             children: [
      //                               InkWell(
      //                                 onTap: () {
      //                                   Navigator.push(
      //                                     context,
      //                                     generateSlideTransition(
      //                                         ShowReservasi(data: data[index])),
      //                                   );
      //                                 },
      //                                 child: Container(
      //                                   margin: EdgeInsets.all(10),
      //                                   decoration: BoxDecoration(
      //                                     color: mWhite,
      //                                     borderRadius:
      //                                         BorderRadius.circular(10),
      //                                     boxShadow: styleBoxShadow,
      //                                   ),
      //                                   child: Column(
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.end,
      //                                     children: [
      //                                       Container(
      //                                         width: 100,
      //                                         color: Colors.amber,
      //                                         child: Padding(
      //                                           padding:
      //                                               const EdgeInsets.all(8.0),
      //                                           child: Text(
      //                                             formatStatus(data[index]
      //                                                 .status
      //                                                 .toString()),
      //                                             textAlign: TextAlign.center,
      //                                           ),
      //                                         ),
      //                                       ),
      //                                       Container(
      //                                         margin: EdgeInsets.only(
      //                                             left: 20, bottom: 10),
      //                                         child: Column(
      //                                           children: [
      //                                             SizedBox(height: 10),
      //                                             Row(
      //                                               children: [
      //                                                 Row(
      //                                                   children: [
      //                                                     Container(
      //                                                       child: Icon(
      //                                                         Icons.store,
      //                                                         color: mPrimary,
      //                                                       ),
      //                                                     ),
      //                                                     SizedBox(
      //                                                       width: 10,
      //                                                     ),
      //                                                     Text(
      //                                                       data[index]
      //                                                               .outletName!
      //                                                               .toUpperCase() +
      //                                                           ' | ' +
      //                                                           data[index]
      //                                                               .subOutletName!
      //                                                               .toUpperCase(),
      //                                                       style: TextStyle(
      //                                                           fontSize: 16,
      //                                                           color: mBlack,
      //                                                           fontWeight:
      //                                                               FontWeight
      //                                                                   .bold),
      //                                                     )
      //                                                   ],
      //                                                 ),
      //                                               ],
      //                                             ),
      //                                             SizedBox(
      //                                               height: 10,
      //                                             ),
      //                                             Row(
      //                                               children: [
      //                                                 Icon(
      //                                                   Icons.person,
      //                                                   color: mPrimary,
      //                                                 ),
      //                                                 SizedBox(
      //                                                   width: 10,
      //                                                 ),
      //                                                 Text(
      //                                                   data[index]
      //                                                       .patientName!
      //                                                       .toUpperCase(),
      //                                                   style: TextStyle(
      //                                                       fontSize: 16,
      //                                                       color: mBlack,
      //                                                       fontWeight:
      //                                                           FontWeight
      //                                                               .bold),
      //                                                 )
      //                                               ],
      //                                             ),
      //                                             SizedBox(
      //                                               height: 10,
      //                                             ),
      //                                             Row(
      //                                               children: [
      //                                                 Icon(
      //                                                   Icons.timer,
      //                                                   color: mPrimary,
      //                                                 ),
      //                                                 SizedBox(
      //                                                   width: 10,
      //                                                 ),
      //                                                 Text(
      //                                                   formatDate(data[index]
      //                                                       .reservationDate!),
      //                                                   style: TextStyle(
      //                                                       fontSize: 14,
      //                                                       color: mBlack,
      //                                                       fontWeight:
      //                                                           FontWeight
      //                                                               .bold),
      //                                                 )
      //                                               ],
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ),
      //                             ],
      //                           );
      //                         },
      //                       );
      //                     },
      //                     loading: () => Center(
      //                       child: CircularProgressIndicator(),
      //                     ),
      //                     error: (error, st) {
      //                       final er = error as Map<String, dynamic>;
      //                       return ListView(
      //                         children: [
      //                           Center(
      //                             child: Text(er['msg']),
      //                           )
      //                         ],
      //                       );
      //                     },
      //                   );
      //                 },
      //               ),
      //             ),
      //             ProviderListener<StateController<bool>>(
      //               onChange: (context, loading) async {
      //                 if (loading.state) {
      //                   await LoadingWidget.showDialogLoading(context);
      //                 } else {
      //                   Navigator.pop(context);
      //                   controller.animateTo(
      //                     controller.position.maxScrollExtent,
      //                     duration: Duration(seconds: 1),
      //                     curve: Curves.fastOutSlowIn,
      //                   );
      //                 }
      //               },
      //               provider: globalLoading,
      //               child: Container(),
      //             ),
      //           ],
      //         ),
      // ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buat Reservasi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Silahkan Pilih Hewan Kesayangan Anda',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _animals.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_animals[index]),
                    value: _selectedAnimals.contains(_animals[index]),
                    onChanged: (value) {
                      if (value!) {
                        setState(() {
                          _selectedAnimals.add(_animals[index]);
                        });
                      } else {
                        setState(() {
                          _selectedAnimals.remove(_animals[index]);
                        });
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text('Kembali'),
                onPressed: () {},
              ),
              ElevatedButton(
                child: Text('Selanjutnya'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => Reservations_2()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() async {
    if (controller.position.extentAfter == 0) {
      context.read(globalLoading).state = true;
      await context.read(reservationProvider.notifier).nextPage();
      context.read(globalLoading).state = false;
    }
  }
}
