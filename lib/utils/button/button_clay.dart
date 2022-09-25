import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:medico_app/utils/const_color.dart';

class button_clay extends StatefulWidget {
  const button_clay(
      {Key? key,
      required this.baseColor,
      required this.baseIcon,
      required this.onPressed})
      : super(key: key);

  final Color baseColor;
  final IconData baseIcon;
  final VoidCallback onPressed;
  @override
  State<button_clay> createState() => _button_clayState();
}

class _button_clayState extends State<button_clay> {
  bool isPressed = true;

  @override
  Widget build(BuildContext context) {
    Offset distace = isPressed ? Offset(3, 3) : Offset(8, 8);
    double blur = isPressed ? 8.0 : 10.0;
    return InkWell(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 1000),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.baseColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: blur,
                  offset: -distace,
                  color: Color.fromARGB(255, 136, 135, 135),
                  inset: true),
              BoxShadow(
                  blurRadius: blur,
                  offset: distace,
                  color: Colors.white,
                  inset: true)
            ]),
        child: Container(
          height: 60,
          width: 60,
          child: Center(
            child: Icon(
              widget.baseIcon,
              color: mPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
