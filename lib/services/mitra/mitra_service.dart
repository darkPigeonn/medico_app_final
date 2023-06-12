import 'dart:convert';
import 'dart:developer';

import 'package:medico_app/models/mitra/mitra_model.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MitraService {
  getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(keyPref);
  }

  Future<MitraModel> getMitra(String id) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra service ==> get mitra...");

      final url = Uri.parse(urlApi + 'v1/mitra/$id');
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
        MitraModel objects = data['data'];

        return objects;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> updateMitra(String id, MitraModel mitra) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra service ==> uupdate mitra...");

      final url = Uri.parse(urlApi + 'v1/mitra/$id');
      final token = await getToken();

      var dataBody = mitra;

      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: dataBody);

      var dataErr;
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'code': '200', 'msg': 'update data berhasil'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> registerMitra(
      String namaMitra, String alamat, LatLng latlng) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra service ==> register...");
      final url = Uri.parse(urlApi + 'mitra-register');
      final token = await getToken();

      Map dataBody = {
        "name": namaMitra,
        "address": alamat,
        "workshopLocation": {"type": "point", "coordinate": latlng},
        "requestLocation": {"type": "point", "coordinate": latlng}
      };

      final response = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: json.encode(dataBody),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      var dataErr;
      if (response.statusCode == 200) {
        return {'code': '200', 'msg': 'verifikasi OTP berhasil'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra service ==> otp...");
      final url = Uri.parse(urlApi + 'mitra-verify-otp');
      final token = await getToken();

      Map dataBody = {'otp': otp, 'phone': phone};
      final response = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: json.encode(dataBody),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      var dataErr;
      if (response.statusCode == 200) {
        return {'code': '200', 'msg': 'verifikasi OTP berhasil'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      log("mitra service ==> send otp...");
      final url = Uri.parse(urlApi + 'mitra-send-otp');
      final token = await getToken();

      Map dataBody = {'phone': phone};

      final response = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: json.encode(dataBody),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);
      var dataErr;
      if (response.statusCode == 200) {
        return {'code': '200', 'msg': 'request OTP berhasil'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }
}
