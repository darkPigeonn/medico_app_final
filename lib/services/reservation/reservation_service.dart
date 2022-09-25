import 'dart:convert';
import 'dart:developer';
import 'package:medico_app/models/outlet/sublist_model.dart';
import 'package:medico_app/models/reservation/layanan_model.dart';
import 'package:medico_app/models/reservation/reservation_model.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReservationService {
  getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(keyPref);
  }

  Future<List<ReservationModel>> getReservation(int page) async {
    try {
      print("auth service ==> get reservation...");

      bool isConnect = await CheckConnectivity.checkConnection();

      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      final url = Uri.parse(urlApi + 'v1/reservations/?page=$page&sort=desc');
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

        return objects.map((e) => ReservationModel.fromJson(e)).toList();
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> storeReservations(Map dataSave) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      final url = Uri.parse(urlApi + 'users/reservation');
      final token = await getToken();
      print(dataSave);
      final response = await http.post(
        url,
        body: json.encode(dataSave),
        headers: {
          "id": APP_ID,
          "secret": APP_SECRET,
          'Authorization': 'Bearer $token',
          "Content-type": "application/json"
        },
      );

      var dataErr;
      var data = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        print(data);
        return data;
      } else {
        dataErr = {'message': data['message']};
        print(dataErr);
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> updateReservation() async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      final url = Uri.parse(urlApi + 'v1/myprofile');

      Map dataBody = {
        "id": "id",
      };

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer ${getToken()}',
        },
      );

      var dataErr;
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return response as Map<String, dynamic>;
      } else {
        dataErr = {'message': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> cancelReservation(String idReservation) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      print("auth service ==> cancel reservasi...");
      final url = Uri.parse(urlApi + 'users/reservation/' + idReservation);
      final token = await getToken();
      print(url);
      Map dataBody = {
        "id": "$idReservation",
      };

      final response = await http.delete(
        url,
        headers: {
          'id': APP_ID,
          'secret': APP_SECRET,
          'Authorization': 'Bearer $token',
        },
      );

      var dataErr;

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'code': responseJson['code'],
          'message': "Berhasil membatalkan reservasi",
        };
      } else {
        dataErr = {'message': responseJson['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<ReservationDataModel>> getUserReservation() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString(keyPref);

    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      print("auth service ==> reservation list...");
      final url = Uri.parse(urlApi + 'users/profile');

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
        var object = data['reservationList'] as List;
        print(object);
        return object.map((e) => ReservationDataModel.fromJson(e)).toList();
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      inspect(e);
      rethrow;
    }
  }
}
