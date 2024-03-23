import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle h1({
  Color color = Colors.black,
}) {
  return GoogleFonts.figtree(
    color: color,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
}

TextStyle h2({
  Color color = Colors.black,
}) {
  return GoogleFonts.figtree(
    color: color,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}

TextStyle h3({
  Color color = Colors.black,
}) {
  return GoogleFonts.figtree(
    color: color,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

TextStyle body1({
  Color color = Colors.black,
}) {
  return GoogleFonts.figtree(
    color: color,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

TextStyle body2({
  Color color = Colors.black,
}) {
  return GoogleFonts.figtree(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

TextStyle body3({
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return GoogleFonts.figtree(
    color: color,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}

TextStyle body4({
  Color color = Colors.black,
}) {
  return GoogleFonts.figtree(
    color: color,
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
}

TextStyle paragraf({
  Color color = Colors.black,
}) {
  return GoogleFonts.figtree(
    color: color,
    fontSize: 12,
    height: 2,
    fontWeight: FontWeight.w400,
  );
}
