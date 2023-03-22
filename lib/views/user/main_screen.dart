import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/views/pets/list_pet.dart';
import 'package:medico_app/views/reservastion/create_screen.dart';

import '../../models/modelResources.dart';
import '../../models/user/user_model.dart';
import '../../providers/user/user_provider.dart';
import '../../utils/card/card_landscape.dart';
import '../../utils/message.dart';
import '../component/header.dart';
import '../notifikasi/notifikasi.dart';
import '../pets/create_pet.dart';
import '../reservastion/index_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserModel? user = UserModel();
  Future<void> getDataProfile() async {
    bool isconnected = await CheckConnectivity.checkConnection();

    if (isconnected) {
      context.read(userProvider.notifier).getDataProfile().then((value) {
        setState(() {
          user = value;
        });
      }).catchError((onError) {
        messageSnackBar(context, onError['msg']);
      });
    } else {
      messageSnackBar(context, 'Tidak ada intenet');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataProfile();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
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
                    HeaderSection(user: user!),
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
                    _PetSection(),
                    SizedBox(
                      height: 20,
                    ),
                    _MenuSection(),
                    // SizedBox(
                    //   height: 30,
                    // ),
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
                    _BlogSection()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PetSection extends StatelessWidget {
  const _PetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreatePet()));
                },
                color: Color.fromARGB(255, 255, 255, 255),
                textColor: Color.fromARGB(255, 0, 13, 194),
                child: Icon(
                  Icons.add,
                  size: 20,
                ),
                padding: EdgeInsets.all(10),
                shape: CircleBorder(),
              ),
              Text('Tambah Pet')
            ],
          ),
          Column(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListPet()));
                },
                color: Color.fromARGB(255, 255, 255, 255),
                textColor: Color.fromARGB(255, 0, 13, 194),
                child: Icon(
                  Icons.more_horiz,
                  size: 20,
                ),
                padding: EdgeInsets.all(10),
                shape: CircleBorder(),
              ),
              Text('Lebih Banyak')
            ],
          ),
        ],
      ),
    );
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndexReservation()));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    textColor: Color.fromARGB(255, 0, 0, 0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.task,
                          size: 55,
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
                          size: 55,
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

class _AnnouncementSection extends StatelessWidget {
  const _AnnouncementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                'Pengumuman',
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _BlogSection extends StatelessWidget {
  const _BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();
    List<int> list = [1, 2, 3, 4, 5];
    final ModelResources1 modelResources1 = ModelResources1(
        title: 'title',
        content: 'content',
        excerpt: 'excerpt',
        publishDate: 'publishDate',
        author: 'author',
        slug: 'slug',
        imageLink: 'imageLink');

    return Container(
        child: Column(
      children: [
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
      ],
    ));
  }
}
