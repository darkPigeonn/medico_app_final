import 'package:flutter/material.dart';
import 'package:medico_app/models/modelResources.dart';
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
      // appBar: TopNavBar(),
      // bottomNavigationBar: BottomNavbar(),
      body: Stack(
        children: [
          SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Artikel Kesehatan',
                          style: titleSectionLanding,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CorauselCard(title: 'title'),

                        // ClayCard(baseColor: Colors.purple),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListResources(
                                          type: 'Artikel',
                                        ))),
                            child: Text(
                              'Lihat lebih banyak',
                              style: TextStyle(color: mPrimary),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Reservasi',
                          style: titleSectionLanding,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Column(
                                children: [
                                  button_clay(
                                      baseColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      baseIcon: Icons.aod_rounded,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    IndexReservation()));
                                      }),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Daftar Reservasi',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Column(
                                children: [
                                  button_clay(
                                      baseColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      baseIcon: Icons.assignment_rounded,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateReservation()));
                                      }),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Buat Reservasi',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Tentang Kami',
                          style: titleSectionLanding,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Column(
                                children: [
                                  button_clay(
                                      baseColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      baseIcon: Icons.person,
                                      onPressed: () {
                                        print(';');
                                      }),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Dokter')
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Column(
                                children: [
                                  button_clay(
                                      baseColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      baseIcon: Icons.health_and_safety_rounded,
                                      onPressed: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryMedic()));
                                      }),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Layanan')
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Column(
                                children: [
                                  button_clay(
                                      baseColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      baseIcon: Icons.import_contacts_sharp,
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             HistoryMedic()));
                                      }),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Riwayat')
                                ],
                              ),
                            ),
                            // Column(
                            //   children: [
                            //     button_clay(baseColor: Color.fromARGB(255, 255, 255, 255)),
                            //      SizedBox(height: 5,),
                            //     Text('Dokter')
                            //   ],
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Berita',
                          style: titleSectionLanding,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CardLandscape(
                          modelResources1: modelResources1,
                        ),
                        CardLandscape(
                          modelResources1: modelResources1,
                        ),
                        CardLandscape(
                          modelResources1: modelResources1,
                        ),
                        CardLandscape(
                          modelResources1: modelResources1,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListResources(
                                          type: 'Artikel',
                                        ))),
                            child: Text(
                              'Lihat lebih banyak',
                              style: TextStyle(color: mPrimary),
                            ),
                          ),
                        ),
                        // button_clay(baseColor: baseColor, size: size),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
