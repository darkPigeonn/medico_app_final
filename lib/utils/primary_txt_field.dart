import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final TextInputType txtInputType;
  final IconData icon;
  final TextEditingController controller;
  final bool? obsText;
  PrimaryTextField({
    required this.hintText,
    required this.txtInputType,
    required this.icon,
    required this.controller,
    this.obsText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        obscureText: obsText!,
        keyboardType: txtInputType,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          filled: true,
          fillColor: Color(0xFFFFFFFF),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFFA1A6B3),
            fontSize: 14,
          ),
          suffixIcon: Icon(icon, color: Colors.black),
        ),
      ),
    );
  }
}
