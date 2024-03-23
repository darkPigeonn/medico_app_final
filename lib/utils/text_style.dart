import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:basic_utils/basic_utils.dart';

const title =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: mWhite);
const titleSectionLanding =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: mBlack);
const titleCard =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mBlack);

const excerptCard = TextStyle(
  fontSize: 12,
  color: mExcerpt,
);
const subtitle = TextStyle(fontSize: 20, color: mWhite);

// content
const content_titleCard =
    TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: mBlack);

// form
const form_titleContent =
    TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: mBlack);

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

extension CapExtension on String {
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => capitalize(str)).join(" ");
}

extension CurrencyRupiahStringExtension on int {
  String get intToFormatRupiah {
    return NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: 0,
    ).format(this);
  }
}
