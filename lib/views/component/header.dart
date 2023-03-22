import 'package:flutter/material.dart';
import 'package:medico_app/utils/stringcasing_extension.dart';

import '../../models/user/user_model.dart';
import '../../utils/const_color.dart';
import '../../utils/helpers.dart';
import '../notifikasi/notifikasi.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.user});

  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: mPrimary,
                  child: Text(
                    user.name.toString()[0],
                    style: TextStyle(
                      color: mFillColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat ' + getGreeting(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.name.toString().toTitleCase(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            Container(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotifikasiPage()));
                },
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
