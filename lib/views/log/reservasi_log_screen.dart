import 'package:flutter/material.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/providers/log/log_reservasi_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/loading.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class IndexLogReservasi extends StatefulWidget {
  const IndexLogReservasi({Key? key}) : super(key: key);

  @override
  _IndexLogReservasiState createState() => _IndexLogReservasiState();
}

class _IndexLogReservasiState extends State<IndexLogReservasi> {
  formatDate(String? date) {
    if (date != null) {
      initializeDateFormatting();
      final DateTime newDate = DateTime.parse(date);
      final DateFormat format =
          DateFormat('EEEE, d MMMM yyyy hh:mm:ss', 'id_ID');
      final String formatted = format.format(newDate);

      return formatted;
    }
  }

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        elevation: 0,
        backgroundColor: mBackgroundColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.refresh(logReservationProvider);
        },
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  final reservationData = watch(logReservationProvider);
                  return reservationData.when(
                    data: (data) {
                      if (data.length == 0) {
                        return Container(
                          child: Center(
                            child: Text("Tidak Ada Data"),
                          ),
                        );
                      }
                      return ListView.builder(
                        controller: controller,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: data[index].transactionCode == 10
                                        ? mColorNotifTopUp
                                        : data[index].transactionCode == 20
                                            ? mColorNotifRes
                                            : mColorNotifTopUpFail,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: data[index].transactionCode ==
                                                  10
                                              ? mColorNotifTopUpLight
                                              : data[index].transactionCode ==
                                                      20
                                                  ? mColorNotifResLigth
                                                  : mColorNotifTopUpFailLigth,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          data[index].transactionCode == 10
                                              ? "Top Up Berhasil"
                                              : data[index].transactionCode ==
                                                      20
                                                  ? "Bayar Reservasi"
                                                  : "Top Up Gagal",
                                          style: mStyleTitleWhite,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                " ${data[index].note!}",
                                                textAlign: TextAlign.left,
                                                style: mStyleTitleWhite,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Text(
                                                "${formatDate(data[index].eventDate)}",
                                                textAlign: TextAlign.right,
                                                style: mStyleTitleWhite,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    loading: () => Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, st) {
                      final er = error as Map<String, dynamic>;
                      return ListView(
                        children: [
                          Center(
                            child: Text(er['msg']),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            ProviderListener<StateController<bool>>(
              onChange: (context, loading) async {
                if (loading.state) {
                  await LoadingWidget.showDialogLoading(context);
                } else {
                  Navigator.pop(context);
                  controller.animateTo(
                    controller.position.maxScrollExtent,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              provider: globalLoading,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollListener() async {
    if (controller.position.extentAfter == 0) {
      context.read(globalLoading).state = true;
      await context.read(logReservationProvider.notifier).nextPage();
      context.read(globalLoading).state = false;
    }
  }
}
