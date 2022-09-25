import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    if (number == null) {
      number = 0.0;
    }
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      // symbol: 'Rp ',
      symbol: '',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

class ClockFormat {
  static String generateTIme(int time) {
    if (time.toString().length == 1) {
      return "0$time:00";
    } else {
      return "$time:00";
    }
  }
}

class CheckConnectivity {
  static checkConnection() async {
    try {
      final result = await InternetAddress.lookup(urlApiShort);

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}

Color getColorMembership(String membership) {
  if (membership == "silver") {
    return Color(0xFFC5C5C5);
  }

  if (membership == "gold") {
    return Color(0xFFE2A507);
  }

  return Color(0xFF07AEE2);
}
