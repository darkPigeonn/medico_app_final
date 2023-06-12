import 'dart:convert';

import 'package:medico_app/models/mitra/mitra_availibility_model.dart';
import 'package:medico_app/models/mitra/mitra_service_model.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MitraServiceService {
  getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(keyPref);
  }

  Future<List<MitraServiceModel>> getMitraService(
      String idMitra, int page) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra service ==> read...");

      final url =
          Uri.parse(urlApi + 'v1/mitra-services/?mitra=$idMitra&page=$page');
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

        var rv = objects.map((e) => MitraServiceModel.fromJson(e)).toList();

        return rv;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<MitraServiceModel> showMitraService(String id) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra service ==> show...");

      final url = Uri.parse(urlApi + 'v1/mitra-services/$id');
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
        MitraServiceModel objects = data['data'];

        return objects;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> createMitraService(
    String idMitra,
    String namaService,
    List<ServiceAvailability> listAvailability,
    int price,
  ) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra service ==> create...");
      final url = Uri.parse(urlApi + 'mitra-services/create/$idMitra/');
      final token = await getToken();

      Map dataBody = {
        "name": namaService,
        "serviceAvailability": listAvailability,
        "price": price,
        "activeStatus": true
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
        return {'code': '200', 'msg': 'Data berhasil ditambah!'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> updateMitraService(
    String idMitra,
    String namaService,
    List<ServiceAvailability> listAvailability,
    int price,
  ) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra service ==> update...");
      final url = Uri.parse(urlApi + 'mitra-services/$idMitra');
      final token = await getToken();

      Map dataBody = {
        "name": namaService,
        "serviceAvailability": listAvailability,
        "price": price,
        "activeStatus": true
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
        return {'code': '200', 'msg': 'Data berhasil diupbah!'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> deleteMitraService(String id) async {
    try {
      bool isConnect = true;
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("mitra service ==> delete...");
      final url = Uri.parse(urlApi + 'mitra-services/$id');
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
