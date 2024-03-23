import 'package:flutter/material.dart';
import 'package:medico_app/models/user/invoices_model.dart';
import 'package:medico_app/utils/Typography.dart';
import 'package:medico_app/utils/text_style.dart';

class DetailsInvoicePatient extends StatelessWidget {
  final MsList detailPatient;
  const DetailsInvoicePatient({super.key, required this.detailPatient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Layanan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: detailPatient.services!.length,
                  itemBuilder: ((context, index) {
                    Service service = detailPatient.services![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(service.name!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(service.qty.toString() +
                                'x ' +
                                service.price!.intToFormatRupiah),
                            Text(service.subtotal!.intToFormatRupiah),
                          ],
                        ),
                      ],
                    );
                  })),
              const Divider(),
              const Text('Vaksin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: detailPatient.medicines!.length,
                  itemBuilder: ((context, index) {
                    Medicine service = detailPatient.medicines![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(service.name!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(service.qty.toString() +
                                'x ' +
                                service.price!.intToFormatRupiah),
                            Text(service.subtotal!.intToFormatRupiah),
                          ],
                        ),
                      ],
                    );
                  })),
              const Divider(),
              const Text('Custom',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: detailPatient.customItems!.length,
                  itemBuilder: ((context, index) {
                    CustomItem service = detailPatient.customItems![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(service.name!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(service.name!),
                            Text(service.qty.toString() +
                                'x ' +
                                service.price!.intToFormatRupiah),
                            Text(service.subtotal!.intToFormatRupiah),
                          ],
                        ),
                      ],
                    );
                  })),
            ],
          ),
        ),
      )),
    );
  }
}
