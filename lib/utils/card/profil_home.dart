import 'package:flutter/material.dart';
import 'package:medico_app/utils/text_style.dart';

class profilHome extends StatelessWidget {
  const profilHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Material(
                      color: Colors.transparent,
                      child: Image.asset(
                        'assets/images/avatar.png',
                        height: 40,
                        width: 40,
                      )),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    child: Center(
                        child: Text(
                      'Inigo',
                      style: subtitle,
                    )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
