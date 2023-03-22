import 'package:flutter/material.dart';
import 'package:medico_app/views/pets/detail_pet.dart';

import '../../models/modelResources.dart';
import '../../utils/card/card_landscape.dart';

class ListPet extends StatefulWidget {
  const ListPet({super.key});

  @override
  State<ListPet> createState() => _ListPetState();
}

class _ListPetState extends State<ListPet> {
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hewan Kesayanganmu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Cari Hewan...',
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
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DetailPet()));
                    },
                    child: CardLandscapePets(
                      modelResources1: modelResources1,
                    ),
                  ),
                  CardLandscapePets(
                    modelResources1: modelResources1,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
