import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class CustomFonts {
  static TextStyle defaultField(Color color) =>
      GoogleFonts.inder(fontSize: 12, color: color);
  static TextStyle bigButton(Color color) =>
      GoogleFonts.inder(fontSize: 20, color: color);

  static TextStyle bodyText1(Color color) =>
      GoogleFonts.inder(fontSize: 18, color: color);
  static TextStyle bodyText2(Color color) =>
      GoogleFonts.inder(fontSize: 16, color: color);
  static TextStyle bodyText3(Color color) =>
      GoogleFonts.inder(fontSize: 14, color: color);
  static TextStyle bodyText4(Color color) =>
      GoogleFonts.inder(fontSize: 12, color: color);
  static TextStyle bodyText5(Color color) =>
      GoogleFonts.inder(fontSize: 10, color: color);
}
