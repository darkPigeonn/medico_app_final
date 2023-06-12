import 'dart:convert';

import 'package:medico_app/models/user/invoices_model.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InvoicesService {
  getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(keyPref);
  }

  Future<List<InvoicesModel>> getInvoices(int page) async {
    try {
      final url = Uri.parse(urlApi2 + 'invoices/get-all');
      final token = await getToken();

      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      var dataErr;
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var objects = response.body as List;

        return objects.map((e) => InvoicesModel.fromJson(e)).toList();
      } else {
        dataErr = {'msg': data['message']};
        throw (dataErr);
      }
    } catch (e) {
      throw (e);
    }
  }
}
