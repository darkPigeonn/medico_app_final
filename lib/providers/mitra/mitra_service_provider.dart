import 'package:medico_app/models/mitra/mitra_availibility_model.dart';
import 'package:medico_app/models/mitra/mitra_service_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/services/mitra/mitra_service_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mitraServiceProvider = StateNotifierProvider<MitraServiceProvider,
    AsyncValue<List<MitraServiceModel>>>((ref) {
  final mitraServiceData = ref.read(mitraServiceService);

  return MitraServiceProvider(mitraServiceData);
});

class MitraServiceProvider
    extends StateNotifier<AsyncValue<List<MitraServiceModel>>> {
  MitraServiceProvider(this._mitraServiceService,
      [AsyncValue<List<MitraServiceModel>>? state])
      : super(AsyncValue.data([]));

  final MitraServiceService? _mitraServiceService;

  List<MitraServiceModel> datas = [];
  int initPage = 1;
  String? idMitra;

  Future<List<MitraServiceModel>> getData(String idMitra) async {
    try {
      datas = [];
      initPage = 1;
      this.idMitra = idMitra;

      final data =
          await _mitraServiceService!.getMitraService(idMitra, initPage);

      return data;
    } catch (e) {
      throw e;
    }
  }

  Future<List<MitraServiceModel>> nextPage() async {
    try {
      initPage += 1;
      List<MitraServiceModel> data =
          await _mitraServiceService!.getMitraService(this.idMitra!, initPage);

      datas.addAll(data);

      return datas;
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> storeData(
    String idMitra,
    String namaService,
    List<ServiceAvailability> listAvailability,
    int price,
  ) async {
    try {
      final result = await _mitraServiceService!
          .createMitraService(idMitra, namaService, listAvailability, price);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<MitraServiceModel> updateData(
    String id,
  ) async {
    try {
      final result = await _mitraServiceService!.showMitraService(id);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<MitraServiceModel> showData(String id) async {
    try {
      print('mitra availability provider ==> show data..');

      final result = await _mitraServiceService!.showMitraService(id);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> deleteData(String id) async {
    try {
      print('mitra availability provider ==> delete data..');

      final result = await _mitraServiceService!.deleteMitraService(id);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}
