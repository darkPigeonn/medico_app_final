import 'package:medico_app/models/reservation/layanan_model.dart';
import 'package:medico_app/models/reservation/loket_model.dart';
import 'package:medico_app/models/reservation/reservation_model.dart';
import 'package:medico_app/models/reservation/waktu_tersedia_model.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/services/reservation/reservation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationDataProvider = StateNotifierProvider<ReservationDataProvider,
    AsyncValue<List<ReservationDataModel>>>((ref) {
  final reservationsData = ref.read(reservationService);

  return ReservationDataProvider(reservationsData);
});

class ReservationDataProvider
    extends StateNotifier<AsyncValue<List<ReservationDataModel>>> {
  ReservationDataProvider(this._reservationService,
      [AsyncValue<List<ReservationModel>>? state])
      : super(AsyncValue.data([])) {
    getReservation();
  }

  final ReservationService? _reservationService;

  List<ReservationDataModel> datas = [];
  int initPage = 1;

  Future<void> getReservation() async {
    try {
      datas = [];
      initPage = 1;
      state = AsyncValue.loading();
      final data = await _reservationService!.getUserReservation();

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
      List<ReservationDataModel> data =
          await _reservationService!.getUserReservation();

      datas.addAll(data);

      if (mounted) {
        state = AsyncValue.data([...datas]);
      }
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
