import 'package:flutter/material.dart';
import 'app_const.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  AppStyle._();

  // logo text style
  static TextStyle logoStyle() => GoogleFonts.poppins(
      fontWeight: FontWeight.bold, fontSize: 24, color: AppConst.primaryColor);

  // text theme
  static final textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 93,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 58,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 47,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: 33,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );
}
