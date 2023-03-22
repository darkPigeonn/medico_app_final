import 'package:flutter/material.dart';
import 'package:medico_app/views/pets/create_pet.dart';

import '../../models/modelResources.dart';
import '../../utils/card/card_landscape.dart';

class DetailPet extends StatefulWidget {
  const DetailPet({super.key});

  @override
  State<DetailPet> createState() => _DetailPetState();
}

class _DetailPetState extends State<DetailPet> {
  late int _selectedDate;
  late int _selectedMonth;
  late int _selectedYear;

  String _selectedSex = 'Jantan';

  List genders = ['Jantan', 'Betina'];
  final ModelResources1 modelResources1 = ModelResources1(
      title: 'title',
      content: 'content',
      excerpt: 'excerpt',
      publishDate: 'publishDate',
      author: 'author',
      slug: 'slug',
      imageLink: 'imageLink');
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

  List<int> _daysInMonth = List<int>.generate(31, (i) => i + 1);
  List<int> _monthsInYear = List<int>.generate(12, (i) => i + 1);
  List<int> _years = List<int>.generate(100, (i) => DateTime.now().year - i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CreatePet()));
                    },
                    child: Text('Ubah'),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CardPortraitPets(
                    modelResources1: modelResources1,
                  )
                ],
              ),
            ),
            Text(
              'Riwayat Kunjungan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            CardHistory(),
            SizedBox(
              height: 10,
            ),
            CardHistory(),
            SizedBox(
              height: 10,
            ),
            CardHistory(),
            SizedBox(
              height: 10,
            ),
            CardHistory(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}

class CardHistory extends StatelessWidget {
  const CardHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('24 Maret 2020'),
          Text('Groming'),
        ],
      ),
    );
  }
}
