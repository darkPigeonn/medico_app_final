import 'dart:developer';

import 'package:medico_app/models/reservation/reservation_model.dart';
import 'package:medico_app/models/user/respon_top_up.dart';
import 'package:medico_app/models/user/topup_model.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/request_util.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(keyPref);
  }

  Future<UserModel> getDataProfile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString(keyPref);

    // try {
    bool isConnect = await CheckConnectivity.checkConnection();
    if (!isConnect) {
      throw ({'msg': 'tdak ada internet'});
    }

    print("auth service ==> profile...");
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
      UserModel user = UserModel.fromJson(data);
      print("user");
      print(user);
      return user;
    } else {
      dataErr = {'msg': data['message']};
      throw (dataErr);
    }
    // } catch (e) {
    //   print('error bro');
    //   inspect(e);
    //   rethrow;
    // }
  }

  Future<Map<String, dynamic>> updateProfile(
      String id,
      String name,
      String email,
      String phone,
      String password,
      Map<dynamic, dynamic> preferences) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString(keyPref);
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      print("auth service ==> profile...");
      final url = Uri.parse(urlApi + 'v1/myprofile');

      Map dataBody = {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "preferensi": preferences,
      };

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      var dataErr;
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return {
          'code': data['code'],
          'msg': data['message'],
        };
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<UserModel> storeData(
    UserModel user,
    String token,
    String id,
    String nopol,
    String nama,
    int manufactureYear,
    int registrationYear,
    String image,
  ) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      print("auth service ==> profile...");
      final url = Uri.parse(urlApi + 'v1/myprofile');

      Map dataBody = {
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
        "vehicles": [
          {
            "id": id,
            "nopol": nopol,
            "name": nama,
            "manufactur_year": manufactureYear,
            "registration_year": registrationYear,
            "image": image
          },
        ]
      };

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      var dataErr;
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(data['objects']);

        return user;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> deleteVehicle(
      String idVehicle, String token) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      print("auth service ==> profile...");
      final url = Uri.parse(urlApi + 'v1/vehicles/$idVehicle/');

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var dataErr;

      var responseJson = json.decode(response.body);

      if (responseJson['code'] == 200) {
        return {
          'code': responseJson['code'],
          'msg': responseJson['message'],
        };
      } else {
        dataErr = {'msg': responseJson['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<TopUpModel> purchase(
    int nominal,
  ) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      print("auth service ==> profile...");
      final url = Uri.parse(urlApi + 'v1/purchase/');
      final token = await getToken();

      Map dataBody = {"topup": nominal};

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      inspect(response);

      var dataErr;
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        TopUpModel res = TopUpModel.fromJson(data);
        if (res.object!.errorMessages != null) {
          dataErr = {'msg': res.object!.errorMessages};
          throw (dataErr);
        } else {
          return res;
        }
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      inspect(e);
      throw (e);
    }
  }

  Future<ResponseTopUp> getStatusTopUp(String url) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      final uri = Uri.parse(url);

      final response = await http.post(
        uri,
      );

      var data = json.decode(response.body);

      ResponseTopUp res = ResponseTopUp.fromJson(data);

      return res;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> createVital(
      String id, Map<String, int> data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString(keyPref);
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      final url = Uri.parse(urlApi + 'users/patient/' + id + '/vitals');
      print(url);
      Map dataBody = data;

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {
          "id": APP_ID,
          "secret": APP_SECRET,
          'Authorization': 'Bearer $token',
          "Content-type": "application/json"
        },
      );

      var responseJson = json.decode(response.body);

      return {
        'code': responseJson['code'],
        'msg': responseJson['message'],
      };
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

  // Future<String> getDataVital() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   String? token = sp.getString(keyPref);
  //   try {
  //     bool isConnect = await CheckConnectivity.checkConnection();
  //     if (!isConnect) {
  //       throw ({'msg': 'tidak ada internet'});
  //     }

  //     print("user service ==> service get vital..");
  //     final url = Uri.parse(urlApi + 'users/profile');

  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'id': APP_ID,
  //         'secret': APP_SECRET,
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     var dataErr;
  //     var data = json.decode(response.body);

  //     if (response.statusCode == 200) {
  //       List<Vital>?
  //       print(data['patientList'][0]['vitalList']);
  //     }

  //     return 'hai';
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
}
