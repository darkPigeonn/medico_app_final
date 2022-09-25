import 'package:flutter/material.dart';
import 'package:medico_app/utils/const_color.dart';

class NominalContainer extends StatelessWidget {
  const NominalContainer({Key? key, required this.onTap, required this.label})
      : super(key: key);

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          this.onTap();
        },
        child: Container(
          margin: EdgeInsets.all(5),
          alignment: Alignment.center,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: mColorCardDark,
          ),
          // color: Colors.grey,
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
