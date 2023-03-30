import 'package:flutter/material.dart';
import 'package:medico_app/models/modelResources.dart';
import 'package:medico_app/providers/reservation/reservationData_provider%20.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/button/button_clay.dart';
import 'package:medico_app/utils/card/card_landscape.dart';
import 'package:medico_app/utils/card/coraulse_card.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/text_style.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/log/notifikasi_log_screen.dart';
import 'package:medico_app/views/log/saldo_log_screen.dart';
import 'package:medico_app/views/reservastion/create_screen.dart';
import 'package:medico_app/views/reservastion/index_screen.dart';
import 'package:medico_app/views/resources/listresources.dart';
import 'package:medico_app/views/user/topup/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../component/pets.dart';
import '../component/topbar.dart';
import '../notifikasi/notifikasi.dart';
import '../reservastion/show_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isloading = true;
  bool isconnected = true;

  showDialogTopUp(int totalSaldo) {
    Navigator.push(
      context,
      generateSlideTransition(
        IndexTopUp(
          fromDashboard: true,
          tagihanSaatIni: 0,
        ),
      ),
    );
  }

  initialData() async {
    isconnected = await CheckConnectivity.checkConnection();

    if (isconnected) {
      context.refresh(userProviderData).catchError((onError) {
        setState(() {
          isloading = false;
        });
        messageSnackBar(context, 'Tidak ada intenet ni');
      });

      setState(() {
        isloading = false;
      });
    } else {
      messageSnackBar(context, 'Tidak ada intenet');
    }
  }

  @override
  void initState() {
    initialData();
    super.initState();
  }

  ScrollController controller = ScrollController();
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

  formatDate(String? date) {
    if (date != null) {
      initializeDateFormatting();
      final DateTime newDate = DateTime.parse(date);
      final DateFormat format = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
      final String formatted = format.format(newDate);

      return formatted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ModelResources1 modelResources1 = ModelResources1(
        title: 'title',
        content: 'content',
        excerpt: 'excerpt',
        publishDate: 'publishDate',
        author: 'author',
        slug: 'slug',
        imageLink: 'imageLink');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 68, 255),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              height: double.infinity,
              margin: EdgeInsets.only(top: size.height * 0.35),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Rawat hewan kesayanganmu',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    PetsSection(),
                    SizedBox(
                      height: 20,
                    ),
                    _MenuSection(),
                    SizedBox(
                      height: 30,
                    ),
                    // _AnnouncementSection(),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Baca Artikel Terkini',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // _BlogSection()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ]),
    );
  }

  Widget _buildTop() {
    Color _color1 = Color(0xFF005288);
    Color _color2 = Color(0xFF37474f);
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Hero(
              tag: 'profilePicture',
              child: ClipOval(
                child: Text('A'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Robert Steven',
                      style: TextStyle(
                          color: _color2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          GestureDetector(
            onTap: () {},
            child: Text('Log Out',
                style: TextStyle(color: _color2, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

class ReservationsToday extends StatelessWidget {
  const ReservationsToday({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final reservationData = watch(reservationDataProvider);
        return reservationData.when(
            data: (data) {
              if (data.length == 0) {
                return Text('Tidak Ada Data');
              }
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          generateSlideTransition(
                            ShowReservasi(data: data[index]),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: mWhite,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: styleBoxShadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            color: Colors.amber,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                formatStatus(data[index].status.toString()),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, bottom: 10),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.store,
                                            color: mPrimary,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          data[index]
                                                  .outletName!
                                                  .toUpperCase() +
                                              ' | ' +
                                              data[index]
                                                  .subOutletName!
                                                  .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: mBlack,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: mPrimary,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      data[index].patientName!.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: mBlack,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: mPrimary,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      formatDate(data[index].reservationDate!),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: mBlack,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
            error: (error, st) {
              return Center(child: Text('Kosong'));
            });
      },
    );
  }

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
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    textColor: Color.fromARGB(255, 0, 0, 0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.task,
                          size: 60,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Daftar Reservasi')
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateReservation(),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    textColor: Color.fromARGB(255, 0, 0, 0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_task,
                          size: 60,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Buat Reservasi')
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
