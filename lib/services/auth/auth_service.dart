import 'package:flutter/widgets.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/request_util.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void saveLimiter() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getInt('limit_login') == null) {
      sp.setInt('limit_login', 0);
    } else {
      var countLimit = sp.getInt('limit_login');
      if (countLimit != null) {
        countLimit++;
        sp.setInt('limit_login', countLimit);
      }
    }
  }

  void clearLimiter() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('limit_login', 0);
  }

  getDeviceId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final deviceId = sp.getString("pref_last_device_id");

    return deviceId;
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      print("auth service ==> register...");
      final url = Uri.parse(urlApi + 'users/session');
      final deviceId = await getDeviceId();

      Map dataBody = {
        'username': phone,
        'password': password,
        // 'device_id': deviceId
      };

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {
          "id": APP_ID,
          "secret": APP_SECRET,
          "Content-type": "application/json"
        },
      );

      var dataErr;
      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        clearLimiter();
        saveSessionUser(data['profileToken']);
        return data;
      } else {
        saveLimiter();
        dataErr = {'code': data['code'], 'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> registrasi(
      String name, String email, String phone, String password) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }

      print("auth service ==> register...");
      final url = Uri.parse(urlApi + 'register');
      final deviceId = await getDeviceId();

      Map data = {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'device_id': deviceId
      };

      final response = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: json.encode(data),
      );

      var dataErr;

      var jsonData = json.decode(response.body);
      if (jsonData['code'] == 200) {
        return {'code': '200', 'msg': 'berhasil ragistrasi'};
      } else {
        dataErr = {'msg': jsonData['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("auth service ==> otp...");
      final url = Uri.parse(urlApi + 'verify-otp?phone=$phone');
      final deviceId = await getDeviceId();
      Map dataBody = {'otp': otp, 'phone': phone, 'device_id': deviceId};
      final response = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: json.encode(dataBody),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      var dataErr;
      if (response.statusCode == 200) {
        saveSessionUser(data['token']);
        return data;
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> resednOtp(String phone) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("auth service ==> resend otp...");
      final url = Uri.parse(urlApi + 'send-otp');

      Map dataBody = {'phone': phone};

      final response = await http.post(
        url,
        headers: {"Content-type": "application/json"},
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

  Future<Map<String, dynamic>> forgotPassword(String phone) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      print("auth service ==> forget password...");
      final url = Uri.parse(urlApi + 'forgot-password/');

      Map dataBody = {'phone': phone};

      final response = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: json.encode(dataBody),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      var dataErr;
      if (response.statusCode == 200) {
        return {'code': '200', 'msg': 'kode OTP terikirim'};
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> verifyForgotPassword(
      String phone, String otp) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      final url = Uri.parse(urlApi + 'verify-forgot-password/');

      Map dataBody = {'phone': phone, 'otp': otp};

      final response = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: json.encode(dataBody),
      );
      var dataErr;
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'code': '200',
          'msg': 'kode OTP terikirim',
          'token': data['token']
        };
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> storeResetPassword(
      String password, String vPassword, String token) async {
    try {
      bool isConnect = await CheckConnectivity.checkConnection();
      if (!isConnect) {
        throw ({'msg': 'tdak ada internet'});
      }
      final url = Uri.parse(urlApi + 'reset-password/$token');

      Map dataBody = {'password': password, 'verify_password': vPassword};

      final response = await http.post(
        url,
        headers: {"Contexxxxxnt-type": "application/json"},
        body: json.encode(dataBody),
      );
      var dataErr;
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'code': '200',
          'msg': 'password berhasil diganti, silahkan login ulang!',
        };
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<bool> saveSessionUser(String token) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final result = sp.setString(keyPref, token);

      debugPrint('save session user : $result');

      return true;
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  Future<String?> readSessionUser() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString(keyPref);

    return token;
  }

  Future<bool> removeSessionUser() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final result = await sp.remove(keyPref);

      sp.clear();
      debugPrint('remove session user : $result');
      return result;
    } catch (e) {
      debugPrint('remove session user failed : $e');
      return false;
    }
  }
}
