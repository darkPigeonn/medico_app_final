import 'package:medico_app/models/user/invoices_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medico_app/services/invoices/invoices_service.dart';

final invoicesProvider =
    StateNotifierProvider<InvoicesProvider, AsyncValue<List<InvoicesModel>>>(
        (ref) {
  final invoicesData = ref.read(invoicesService);

  return InvoicesProvider(invoicesData);
});

class InvoicesProvider extends StateNotifier<AsyncValue<List<InvoicesModel>>> {
  InvoicesProvider(this._invoicesService,
      [AsyncValue<List<InvoicesModel>>? state])
      : super(AsyncValue.data([])) {
    getInvoices();
  }

  final InvoicesService? _invoicesService;

  List<InvoicesModel> datas = [];
  int initPage = 1;

  Future<void> getInvoices() async {
    try {
      datas = [];
      initPage = 1;
      state = AsyncValue.loading();

      final data = await _invoicesService!.getInvoices(initPage);

      if (mounted) {
        datas = data;
        state = AsyncValue.data([...data]);
      }
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
