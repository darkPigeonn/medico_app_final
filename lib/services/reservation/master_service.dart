import 'dart:convert';
import 'package:medico_app/models/outlet/outlet_model.dart';
import 'package:medico_app/models/reservation/layanan_model.dart';
import 'package:medico_app/models/reservation/loket_model.dart';
import 'package:medico_app/models/reservation/waktu_tersedia_model.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MasterService {
  getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(keyPref);
  }

  Future<List<OutletModel>> getLokets() async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      final url = Uri.parse(urlApi + 'users/outlets');
      final token = await getToken();

      final response = await http.get(
        url,
        headers: {
          'id': APP_ID,
          'secret': APP_SECRET,
        },
      );

      var dataErr;
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var objects = data as List;

        var rv = objects.map((e) => OutletModel.fromJson(e)).toList();

        return rv;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<Layanan>> getLayanan(String outlet) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      final url = Uri.parse(urlApi + 'v1/ulservices/?outlets=$outlet');
      final token = await getToken();

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var dataErr;
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var objects = data['data']['objects'] as List;
        return objects.map((e) => Layanan.fromJson(e)).toList();
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<WaktuTersedia>> getWaktuTersedia(
      String outlet, String date, String servicesId) async {
    try {
      bool isConnect = true;

      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print(date);
      print(outlet);
      print(date);
      print(date);
      var dateFormat = DateFormat('dd-MM-yyyy');
      var newDate = dateFormat.format(DateTime.parse(date)).toString();
      final url =
          // Uri.parse(urlApi + 'users/reservation/$outlet/quota/$newDate');
          Uri.parse(urlApi + 'users/reservation/$outlet/quota/$newDate');
      print(url);
      final token = await getToken();

      final response = await http.get(
        url,
        headers: {
          'id': APP_ID,
          'secret': APP_SECRET,
          'Authorization': 'Bearer $token',
        },
      );

      var dataErr;
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var objects = data['slots'] as List;
        return objects.map((e) => WaktuTersedia.fromJson(e)).toList();
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }
}
