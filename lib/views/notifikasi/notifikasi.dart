import 'package:flutter/material.dart';

class Item {
  final String date;
  final String content;

  Item({required this.date, required this.content});
}

class NotifikasiPage extends StatelessWidget {
  final List<Item> items = [
    Item(date: '12 Feb 2023', content: 'Lorem ipsum dolor sit amet'),
    Item(date: '15 Feb 2023', content: 'consectetur adipiscing elit'),
    Item(
        date: '18 Feb 2023',
        content:
            'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Item(date: '22 Feb 2023', content: 'Ut enim ad minim veniam'),
    Item(
        date: '25 Feb 2023',
        content:
            'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat'),
    Item(
        date: '28 Feb 2023',
        content:
            'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'),
  ];

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
              Text(
                'Notifikasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.date,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(item.content),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
