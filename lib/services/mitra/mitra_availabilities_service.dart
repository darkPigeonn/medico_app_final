import 'dart:convert';

import 'package:medico_app/models/mitra/mitra_availibility_model.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MitraAvailabilityService {
  getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(keyPref);
  }

  Future<List<ServiceAvailability>> getMitraAvailability(int page) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra avaiibility ==> read...");

      final url =
          Uri.parse(urlApi + 'v1/mitra-services-availabilities&page=$page');
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

        var rv = objects.map((e) => ServiceAvailability.fromJson(e)).toList();

        return rv;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<ServiceAvailability> showMitraAvailability(String id) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra avaiibility ==> show...");

      final url = Uri.parse(urlApi + 'v1/mitra-services-availabilities/$id');
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
        ServiceAvailability objects =
            ServiceAvailability.fromJson(data['data']);

        return objects;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> createMitraAvailabilities(String nama) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra avaiibility ==> create...");
      final url = Uri.parse(urlApi + 'mitra-services-availabilities-create');
      final token = await getToken();

      Map dataBody = {"name": nama};

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
        return {'code': '200', 'msg': 'Data berhasil ditambah!'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> updateMitraAvailabilities(
      String id, String nama) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra avaiibility ==> update...");
      final url =
          Uri.parse(urlApi + 'mitra-services-availabilities-create/$id');
      final token = await getToken();

      Map dataBody = {"id": id, "name": nama};

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
        return {'code': '200', 'msg': 'Data berhasil diupbah!'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> deleteMitraAvailabilities(String id) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra avaiibility ==> delete...");
      final url = Uri.parse(urlApi + 'mitra-services-availabilities/$id');
      final token = await getToken();

      final response = await http.delete(
        url,
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      var dataErr;
      if (response.statusCode == 200) {
        return {'code': '200', 'msg': 'Data berhasil dihapus!'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }
}
