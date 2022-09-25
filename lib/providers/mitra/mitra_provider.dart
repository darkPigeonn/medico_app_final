import 'package:medico_app/models/mitra/mitra_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/services/mitra/mitra_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final mitraProvider = StateNotifierProvider<MitraProvider, MitraModel>((ref) {
  final ms = ref.read(mitraService);
  return MitraProvider(ms);
});

class MitraProvider extends StateNotifier<MitraModel> {
  MitraProvider(this._mitraService) : super(MitraModel());

  final MitraService? _mitraService;

  Future<MitraModel> getMitra(String id) async {
    try {
      print('mitra provider ==> get mitra..');
      var result = await _mitraService!.getMitra(id);
      return result;
    } catch (e) {
      print('mitra provider ==> get mitra error..');
      throw (e);
    }
  }

  Future<Map<String, dynamic>> register(
      String namaMitra, String alamat, LatLng latlng) async {
    try {
      print('mitra provider ==> register..');
      var result =
          await _mitraService!.registerMitra(namaMitra, alamat, latlng);

      return result;
    } catch (e) {
      print('mitra provider ==> register error..');
      throw (e);
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    try {
      print('mitra provider ==> verify otp..');
      var result = await _mitraService!.verifyOtp(phone, otp);

      return result;
    } catch (e) {
      print('mitra provider ==> verify otp error..');
      throw (e);
    }
  }

  Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      print('mitra provider ==> resend otp..');
      var result = await _mitraService!.sendOtp(phone);

      return result;
    } catch (e) {
      print('mitra provider ==> resend otp error..');
      throw (e);
    }
  }
}
