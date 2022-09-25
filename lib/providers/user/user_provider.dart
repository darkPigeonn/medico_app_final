import 'package:medico_app/models/reservation/reservation_model.dart';
import 'package:medico_app/models/user/respon_top_up.dart';
import 'package:medico_app/models/user/topup_model.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/services/user/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserProvider, UserModel>((ref) {
  final us = ref.read(userService);
  return UserProvider(us);
});

final userProviderData = FutureProvider<UserModel>((ref) {
  final upd = ref.watch(userService);
  return upd.getDataProfile();
});

class UserProvider extends StateNotifier<UserModel> {
  UserProvider(this._userService, [UserModel? state]) : super(UserModel()) {
    getDataProfile();
  }

  final UserService? _userService;

  Future<UserModel> getDataProfile() async {
    try {
      print('user provider ==> get data..');
      final result = await _userService!.getDataProfile();
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> storeDataProfile(
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
      print('user provider ==> store data..');

      final result = await _userService!.storeData(user, token, id, nopol, nama,
          manufactureYear, registrationYear, image);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> updateProfile(
      String id,
      String name,
      String email,
      String phone,
      String password,
      Map<dynamic, dynamic> preferences) async {
    try {
      print('user provider ==> update prodile..');

      final result = await _userService!
          .updateProfile(id, name, email, phone, password, preferences);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> deleteVehicle(String id, String token) async {
    try {
      print('user provider ==> delete data..');

      final result = await _userService!.deleteVehicle(id, token);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<TopUpModel> topUp(int nominal) async {
    try {
      final data = await _userService!.purchase(nominal);

      return data;
    } catch (e) {
      throw (e);
    }
  }

  Future<ResponseTopUp> getStatusTopUp(String url) async {
    try {
      print('user provider ==> get status topup..');

      final result = await _userService!.getStatusTopUp(url);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> createVital(
      String id, Map<String, int> data) async {
    try {
      final result = await _userService!.createVital(id, data);
      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<ReservationDataModel>> getUserReservation() async {
    try {
      print('user provider ==> get data..');
      final result = await _userService!.getUserReservation();
      return result;
    } catch (e) {
      throw e;
    }
  }

  // //medical
  // Future<String> getVital() async {
  //   try {
  //     print('user provide ==> get data vital...');
  //     final result = await _userService!.getDataVital();
  //     return 'hai';
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
}
