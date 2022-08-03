import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData? appTheme;

  static final themeData = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: const Color(0xFFEEEEEE),
      scaffoldBackgroundColor: const Color(0xFFEEEEEE),
      textTheme: TextTheme(
        headline6: GoogleFonts.inder().copyWith(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: GoogleFonts.inder().copyWith(
          fontSize: 18,
        ),
        bodyText2: GoogleFonts.inder().copyWith(
          fontSize: 16,
        ),
        caption: GoogleFonts.inder().copyWith(
          fontSize: 12,
        ),
        button: GoogleFonts.inder().copyWith(
          fontSize: 14,
        ),
        subtitle1: GoogleFonts.inder().copyWith(
          fontSize: 14,
        ),
        subtitle2: GoogleFonts.inder().copyWith(
          fontSize: ScreenUtil().setSp(12),
        ),
        overline: GoogleFonts.inder().copyWith(
          fontSize: ScreenUtil().setSp(12),
        ),
      ));
}
