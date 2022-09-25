import 'package:medico_app/models/mitra/mitra_availibility_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/services/mitra/mitra_availabilities_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mitraAvailabilityProvider = StateNotifierProvider<
    MitraAvailabilityProvider, AsyncValue<List<ServiceAvailability>>>((ref) {
  final mitraAvailabilityData = ref.read(mitraAvailabilityService);

  return MitraAvailabilityProvider(mitraAvailabilityData);
});

class MitraAvailabilityProvider
    extends StateNotifier<AsyncValue<List<ServiceAvailability>>> {
  MitraAvailabilityProvider(this._mitraAvailabilityService,
      [AsyncValue<List<ServiceAvailability>>? state])
      : super(AsyncValue.data([])) {
    getData();
  }

  final MitraAvailabilityService? _mitraAvailabilityService;

  List<ServiceAvailability> datas = [];
  int initPage = 1;

  Future<void> getData() async {
    try {
      datas = [];
      initPage = 1;
      state = AsyncValue.loading();

      final data =
          await _mitraAvailabilityService!.getMitraAvailability(initPage);

      if (mounted) {
        datas = data;
        state = AsyncValue.data([...data]);
      }
    } catch (e) {
      state = AsyncError(e);
    }
  }

  Future<void> nextPage() async {
    try {
      initPage += 1;
      List<ServiceAvailability> data =
          await _mitraAvailabilityService!.getMitraAvailability(initPage);

      datas.addAll(data);

      if (mounted) {
        state = AsyncValue.data([...datas]);
      }
    } catch (e) {
      state = AsyncError(e);
    }
  }

  Future<Map<String, dynamic>> storeData(
    String nama,
  ) async {
    try {
      final result =
          await _mitraAvailabilityService!.createMitraAvailabilities(nama);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> updateData(
    String id,
    String nama,
  ) async {
    try {
      final result =
          await _mitraAvailabilityService!.updateMitraAvailabilities(id, nama);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> showData(String id) async {
    try {
      print('mitra availability provider ==> show data..');

      final result =
          await _mitraAvailabilityService!.deleteMitraAvailabilities(id);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> deleteData(String id) async {
    try {
      print('mitra availability provider ==> delete data..');

      final result =
          await _mitraAvailabilityService!.deleteMitraAvailabilities(id);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}
