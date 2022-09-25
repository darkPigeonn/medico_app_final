import 'package:flutter/material.dart';

void messageSnackBar(BuildContext context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}

void messageSnackBarColor(BuildContext context, msg, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(msg),
    ),
  );
}
