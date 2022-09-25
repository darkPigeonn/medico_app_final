import 'package:medico_app/models/logs/log_reservasi_model.dart';

import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/services/logs/log_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logReservationProvider =
    StateNotifierProvider<LogReservasi, AsyncValue<List<LogReservasiModel>>>(
        (ref) {
  final reservationData = ref.read(logService);

  return LogReservasi(reservationData);
});

class LogReservasi extends StateNotifier<AsyncValue<List<LogReservasiModel>>> {
  LogReservasi(this._logService, [AsyncValue<List<LogReservasiModel>>? state])
      : super(AsyncValue.data([])) {
    getLogReservation();
  }

  final LogService? _logService;

  List<LogReservasiModel> datas = [];
  int initPage = 1;

  Future<void> getLogReservation() async {
    try {
      datas = [];
      initPage = 1;
      state = AsyncValue.loading();

      final data = await _logService!.getLogReservasi(initPage);

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
      List<LogReservasiModel> data =
          await _logService!.getLogReservasi(initPage);

      datas.addAll(data);

      if (mounted) {
        state = AsyncValue.data([...datas]);
      }
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
