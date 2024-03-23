import 'package:flutter/material.dart';
import 'package:medico_app/utils/Typography.dart';
import 'package:medico_app/utils/request_util.dart';
import 'package:medico_app/views/component/Button.dart';

Future showDialogAlert(
  var context,
  String title,
  String buttonText,
  GestureTapCallback onPressed,
  String subButtonText,
  GestureTapCallback onPressedSub,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: body1(),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonFill(
                  onPressed: onPressed,
                  size: MediaQuery.of(context).size.width - 32,
                  child: Text(
                    buttonText,
                    style: body1(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: onPressedSub,
                  child: Text(
                    subButtonText,
                    style: body4(
                      color: grey1,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Future showDialogLoading(
  var context,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: grey1,
            ),
          ),
        ),
      );
    },
  );
}
