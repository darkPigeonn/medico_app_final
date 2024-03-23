// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medico_app/utils/Typography.dart';
import 'package:medico_app/utils/request_util.dart';

class ButtonFill extends StatelessWidget {
  GestureTapCallback onPressed;
  final Widget child;
  final double size;
  ButtonFill({
    super.key,
    required this.onPressed,
    required this.size,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: RawMaterialButton(
        fillColor: primary,
        splashColor: Color.fromARGB(255, 206, 156, 82),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }
}

class ButtonOutlined extends StatelessWidget {
  final GestureTapCallback onPressed;
  final Widget child;
  final double size;
  const ButtonOutlined({
    super.key,
    required this.onPressed,
    required this.size,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: RawMaterialButton(
        fillColor: Colors.white,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: primary,
              width: 2.0,
            )),
        child: child,
      ),
    );
  }
}

class ButtonProfile extends StatelessWidget {
  final GestureTapCallback onPressed;
  final Icon icon;
  final String title;

  const ButtonProfile({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Image.asset(
                  //   "assets/icon/$image",
                  //   height: 30,
                  //   color: Color.fromARGB(255, 166, 123, 60),
                  // ),
                  icon,
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: body2(),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black38,
                          size: 18,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(
                color: Colors.black38,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonAlamat extends StatelessWidget {
  final GestureTapCallback onPressed;
  const ButtonAlamat({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: primary,
                ),
                SizedBox(width: 8),
                Text(
                  "Masukan alamat secara manual",
                  style: body2(),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black38,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
