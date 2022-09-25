import 'package:medico_app/models/logs/log_saldo_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/services/logs/log_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logSaldoProvider =
    StateNotifierProvider<LogSaldo, AsyncValue<List<LogSaldoModel>>>((ref) {
  final saldoData = ref.read(logService);

  return LogSaldo(saldoData);
});

class LogSaldo extends StateNotifier<AsyncValue<List<LogSaldoModel>>> {
  LogSaldo(this._logService, [AsyncValue<List<LogSaldoModel>>? state])
      : super(AsyncValue.data([])) {
    getLogSaldo();
  }

  final LogService? _logService;

  List<LogSaldoModel> datas = [];
  int initPage = 1;

  Future<void> getLogSaldo() async {
    try {
      datas = [];
      initPage = 1;
      state = AsyncValue.loading();

      final data = await _logService!.getLogSaldo(initPage);

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
      // state = AsyncValue.loading();

      initPage += 1;
      List<LogSaldoModel> data = await _logService!.getLogSaldo(initPage);

      datas.addAll(data);

      if (mounted) {
        state = AsyncValue.data([...datas]);
      }
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
