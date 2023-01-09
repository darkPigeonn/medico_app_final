import 'package:flutter/material.dart';
import 'package:medico_app/providers/user/user_provider.dart';
import 'package:medico_app/utils/message.dart';
import 'package:medico_app/utils/primary_txt_field_format.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/user/topup/status_top_up.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class MyBottomSheet extends StatefulWidget {
  MyBottomSheet({required this.controller});
  TextEditingController controller;

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: PrimaryTextFieldFormat(
                hintText: "Rp",
                txtInputType: TextInputType.text,
                controller: widget.controller,
              ),
            ),
            isloading
                ? Container(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (isloading == false) {
                    setState(() {
                      isloading = true;
                    });
                    int nominal =
                        int.parse(widget.controller.text.replaceAll('.', ''));

                    await context
                        .read(userProvider.notifier)
                        .topUp(nominal)
                        .then((value) {
                      setState(() {
                        isloading = false;
                      });
                      Navigator.push(
                        context,
                        generateSlideTransition(
                          TopUpScreen(
                            data: value,
                            fromDashboard: true,
                            nominal: nominal,
                          ),
                        ),
                      );
                    }).catchError((onError) {
                      messageSnackBar(context, onError['msg']);
                      setState(() {
                        isloading = false;
                      });
                    });

                    setState(() {
                      isloading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFBff0f7b),
                ),
                child: Text(
                  "Purchase",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
