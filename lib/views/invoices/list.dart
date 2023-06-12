import 'package:flutter/material.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/global_provider.dart';
import 'package:medico_app/providers/invoices/invoices_provider.dart';
import 'package:medico_app/providers/reservation/reservationData_provider%20.dart';
import 'package:medico_app/providers/reservation/reservation_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/helpers.dart';
import 'package:medico_app/utils/loading.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/styles.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/log/reservasi_log_screen.dart';
import 'package:medico_app/views/reservastion/show_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({Key? key}) : super(key: key);

  @override
  _InvoicesPageState createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  List<Vehicles> vehicles = [];

  bool isloading = true;

  formatDate(String? date) {
    if (date != null) {
      initializeDateFormatting();
      final DateTime newDate = DateTime.parse(date);
      final DateFormat format = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
      final String formatted = format.format(newDate);

      return formatted;
    }
  }

  formatStatus(String? data) {
    if (data != null) {
      String status = '';
      switch (data) {
        case '0':
          status = 'Menunggu';
          break;
        case '70':
          status = 'Tersejui';
          break;
        default:
          status = 'Ditolak';
      }
      return status;
    }
  }

  initialData() async {
    bool isConnect = true;
    bool isconnected = true;

    if (isconnected) {
      setState(() {
        isloading = false;
      });
      controller = ScrollController()..addListener(_scrollListener);
      context.refresh(invoicesProvider.notifier).getInvoices();
    } else {
      messageSnackBar(context, 'Tidak ada intenet');
    }
  }

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    initialData();
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
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              initialData();
            },
            icon: Icon(
              Icons.replay_outlined,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.refresh(invoicesProvider).getInvoices();
        },
        child: isloading == true
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Consumer(
                      builder: (context, watch, child) {
                        final reservationData = watch(invoicesProvider);

                        return reservationData.when(
                          data: (data) {
                            if (data.length == 0) {
                              return Center(
                                child: Text("Tidak Ada Data"),
                              );
                            }
                            return ListView.builder(
                              controller: controller,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Text(
                                          //   DateFormat('d MMMM yyyy', 'id_ID')
                                          //       .format(data[index]
                                          //           .reservationDate!
                                          //           .toString()),
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyLarge,
                                          // ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: Colors.green,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Selesai',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child:
                                            Divider(thickness: 0.2, height: 1),
                                      ),
                                      const Text('Nama Member :'),
                                      const SizedBox(height: 4),
                                      Text(
                                        " data[index].name.toString()",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: blueColor),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Total :'),
                                              const SizedBox(height: 4),
                                              Text(
                                                "0",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(color: blueColor),
                                              ),
                                            ],
                                          ),
                                          // Text(
                                          //   "transaction.",
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyLarge!
                                          //       .copyWith(color: blueColor),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          loading: () => Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, st) {
                            final er = error.toString();
                            return ListView(
                              children: [
                                Center(
                                  child: Text(er),
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
      await context.read(reservationProvider.notifier).nextPage();
      context.read(globalLoading).state = false;
    }
  }
}
