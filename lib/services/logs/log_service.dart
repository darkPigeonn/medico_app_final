import 'dart:convert';
import 'package:medico_app/models/logs/log_notifikasi_model.dart';
import 'package:medico_app/models/logs/log_reservasi_model.dart';
import 'package:medico_app/models/logs/log_saldo_model.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LogService {
  getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(keyPref);
  }

  Future<List<LogReservasiModel>> getLogReservasi(int page) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      final url = Uri.parse(
          urlApi + 'v1/logs/?transaction_code=20&sort=desc&page=$page');
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

        var rv = objects.map((e) => LogReservasiModel.fromJson(e)).toList();

        return rv;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<LogSaldoModel>> getLogSaldo(int page) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      final url = Uri.parse(
          urlApi + 'v1/logs/?transaction_code=10&sort=desc&page=$page');

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

        var rv = objects.map((e) => LogSaldoModel.fromJson(e)).toList();

        return rv;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<LogNotifikasiModel>> getLogNotifikasi(int page) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      final url = Uri.parse(urlApi + 'v1/logs/?sort=desc&page=$page');
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

        var rv = objects.map((e) => LogNotifikasiModel.fromJson(e)).toList();

        return rv;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }
}
