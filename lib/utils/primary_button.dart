import 'package:flutter/material.dart';
import 'package:medico_app/utils/const_color.dart';

class PrimaryButton extends StatelessWidget {
  final String hint;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const PrimaryButton({
    Key? key,
    required this.hint,
    this.onTap,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: mPrimary,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          hint,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PrimaryButton2 extends StatelessWidget {
  final String hint;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const PrimaryButton2({
    Key? key,
    required this.hint,
    this.onTap,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: mPrimary,
        ),
        alignment: Alignment.center,
        child: Text(
          hint,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
