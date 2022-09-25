import 'package:medico_app/models/reservation/layanan_model.dart';
import 'package:medico_app/models/reservation/loket_model.dart';
import 'package:medico_app/models/reservation/reservation_model.dart';
import 'package:medico_app/models/reservation/waktu_tersedia_model.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/services/reservation/reservation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationProvider = StateNotifierProvider<ReservationProvider,
    AsyncValue<List<ReservationModel>>>((ref) {
  final reservationData = ref.read(reservationService);

  return ReservationProvider(reservationData);
});

class ReservationProvider
    extends StateNotifier<AsyncValue<List<ReservationModel>>> {
  ReservationProvider(this._reservationService,
      [AsyncValue<List<ReservationModel>>? state])
      : super(AsyncValue.data([])) {
    getReservation();
  }

  final ReservationService? _reservationService;

  List<ReservationModel> datas = [];
  int initPage = 1;

  Future<void> getReservation() async {
    try {
      datas = [];
      initPage = 1;
      state = AsyncValue.loading();

      final data = await _reservationService!.getReservation(initPage);

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
      List<ReservationModel> data =
          await _reservationService!.getReservation(initPage);

      datas.addAll(data);

      if (mounted) {
        state = AsyncValue.data([...datas]);
      }
    } catch (e) {
      state = AsyncError(e);
    }
  }

  Future<Map<String, dynamic>> storeReservation(Map dataSave) async {
    try {
      final result = await _reservationService!.storeReservations(dataSave);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map<String, dynamic>> cancelReservation(String id) async {
    try {
      print('user provider ==> delete data..');

      final result = await _reservationService!.cancelReservation(id);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}
