import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:intl/intl.dart';
import 'package:simple_moment/simple_moment.dart';

import 'package:dospace/dospace.dart' as dospace;

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
      print("errro bro");
      print(e);
      return false;
    }
    // return true;
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

getGender(int code) {
  String gender = '-';

  switch (code) {
    case 1:
      gender = 'Jantan';
      break;
    case 2:
      gender = 'Betina';
      break;
    default:
  }

  return gender;
}

getHRDDate(String date) {
  return Moment.parse(date).format('dd MMMM yyyy');
}

Future<String> uploadImages(File file, String id) async {
  // print('hola halo');

  dospace.Spaces spaces = new dospace.Spaces(
    region: "sgp1",
    accessKey: "DO00PP2ZVBNWVGD4Y7V8",
    secretKey: "PNnmfACeClcZCDM8pUk+cBjJCiFYsW3sKX8C1TcM5Go",
  );

  String basePathDigitalOcean = 'https://sgp1.digitaloceanspaces.com/';

  // for (String name in await spaces.listAllBuckets()) {
  //   print('bucket : ${name}');
  // }
  var date = DateTime.now();
  String formattedDate = DateFormat('dd-mm-yyyy').format(date);

  var _fileName = 'pets-' + id;
  var _extension = '.jpg';
  var _contentType = 'image/.jpg';
  var _filePath = file.path;
  var _filePathDigitalOcean =
      "https://cdn.ptalia.co.id" + '/medivet/pets/' + _fileName + _extension;

//downloadLink
//fileName
  dospace.Bucket bucket = spaces.bucket('ptalia');

  try {
    await bucket
        .uploadFile("medivet/pets/" + (_fileName + _extension), file,
            _extension, dospace.Permissions.public)
        .then((value) {});

    Map dataReturn = {
      'statusCode': 200,
      'body': _filePathDigitalOcean,
    };
    return _filePathDigitalOcean;
  } catch (e) {
    throw (e);
  }
}
