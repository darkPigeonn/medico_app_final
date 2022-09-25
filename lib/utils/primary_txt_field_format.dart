import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,###", "id_ID");
    String newText = formatter.format(value / 1);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class PrimaryTextFieldFormat extends StatelessWidget {
  final String hintText;
  final TextInputType txtInputType;
  final IconData? icon;
  final TextEditingController controller;
  final bool? obsText;
  final bool? autoFocus;
  final bool enabled;
  PrimaryTextFieldFormat({
    required this.hintText,
    required this.txtInputType,
    this.icon,
    required this.controller,
    this.obsText = false,
    this.autoFocus = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyPtBrInputFormatter()
      ],
      autofocus: autoFocus!,
      controller: controller,
      obscureText: obsText!,
      keyboardType: txtInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color(0xFFe7edeb),
        hintText: hintText,
        prefixIcon: icon == null ? null : Icon(icon, color: Colors.grey[400]),
      ),
    );
  }
}
