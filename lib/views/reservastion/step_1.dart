import 'package:flutter/material.dart';
import 'package:medico_app/models/outlet/outlet_model.dart';
import 'package:medico_app/models/outlet/sublist_model.dart';
import 'package:medico_app/models/user/user_model.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/primary_txt_field.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/reservastion/step_2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateStep1 extends StatefulWidget {
  final OutletModel outlet;
  const CreateStep1({Key? key, required this.outlet}) : super(key: key);

  @override
  _CreateStep1State createState() => _CreateStep1State();
}

class _CreateStep1State extends State<CreateStep1> {
  List<SublistModel> subList = [];
  bool isLoading = false;

  initialData() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subList = widget.outlet.subList!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.all(2),
            height: double.infinity,
            child: Center(
              child: Text("step 1-3"),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: mPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Klinik - Adi Utama',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: mWhite,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Silahkan Pilih Poli',
                      style: TextStyle(
                        fontSize: 16,
                        color: mWhite,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              ...subList.map(
                                (e) {
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   generateSlideTransitionHorizontal(
                                        //     CreateStep2(
                                        //       sublist: e,
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    height: 90,
                                                    child: SvgPicture.asset(
                                                      'assets/suboutlet.svg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 30),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          e.name.toString(),
                                                          style:
                                                              GoogleFonts.alike(
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        Text(
                                                          e.parentName
                                                              .toString(),
                                                          style:
                                                              GoogleFonts.alike(
                                                                  fontSize: 12,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          202,
                                                                          202,
                                                                          202)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
