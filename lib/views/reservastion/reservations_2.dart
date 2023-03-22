import 'package:flutter/material.dart';
import 'package:medico_app/views/reservastion/reservations_3.dart';

class Reservations_2 extends StatefulWidget {
  const Reservations_2({super.key});

  @override
  State<Reservations_2> createState() => _ReservationsState_2();
}

class _ReservationsState_2 extends State<Reservations_2> {
  List<String> _listServices = [];

  String _selectedServices = '';

  List<String> _animals = [
    'Anjing',
    'Kucing',
    'Hamster',
    'Kelinci',
    'Ikan',
    'Burung',
    'Ular',
    'Kuda',
  ];

  var qtyTotal = 0;
  var total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buat Reservasi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Silahkan Pilih Layanan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              // DropdownButtonFormField<String>(
              //   value: _selectedServices,
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedServices = value!;
              //     });
              //   },
              //   items: _listServices.map((services) {
              //     return DropdownMenuItem<String>(
              //       value: services,
              //       child: Text(services.toString()),
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(
              //     hintText: 'Silahkan Pilih Layanan',
              //     border: OutlineInputBorder(
              //       borderSide: const BorderSide(
              //           color: Color.fromARGB(255, 183, 183, 183)),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //   ),
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // "${value.name}",
                          "Groming",
                          // style: mStyleTitleWhite,
                        ),
                        Text(
                          // "${CurrencyFormat.convertToIdr(value.price, 2)}",
                          "Rp. 50.0000",
                          // style: mStyleTitleWhite,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    // child: value.qtyTotal > 0
                    child: qtyTotal > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: Icon(Icons.remove),
                                ),
                                onTap: () {
                                  setState(() {
                                    qtyTotal -= 1;
                                    total -= 50000;
                                    // value.removeQty(1);
                                    // renderTotalPrice();
                                    // if (value.qtyTotal == 0) {
                                    //   selectedLayanan.removeWhere(
                                    //       (element) =>
                                    //           element.sId == value.sId);
                                    // }
                                  });
                                },
                              ),
                              Text(
                                // '${value.qtyTotal}',
                                '$qtyTotal',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: Icon(Icons.add),
                                ),
                                onTap: () {
                                  setState(() {
                                    qtyTotal += 1;
                                    total += 50000;
                                    // value.addQty(1);
                                    // renderTotalPrice();

                                    // if (totalPrice > saldo) {
                                    //   mustTopup = true;
                                    // }
                                  });
                                },
                              ),
                            ],
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF1FE000),
                                padding: EdgeInsets.all(10)),
                            child: Text(
                              "Tambah",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            onPressed: () {
                              setState(() {
                                qtyTotal += 1;
                                total = 50000;

                                // selectedLayanan.add(value);
                                // value.addQty(1);
                                // renderTotalPrice();
                                // if (totalPrice > saldo) {
                                //   mustTopup = true;
                                // }
                              });
                            },
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$total',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton(
                child: Text('Selanjutnya'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Reservations_3()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
