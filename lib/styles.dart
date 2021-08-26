import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final primaryColor = Color(0xFFFBA40C);
final secondaryColor = Color(0xFFC81C19);
final whiteText = Color(0xFFFFFFFF);
final blackText = Color(0xFF080808);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.quicksand(
      fontSize: 98, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.quicksand(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.quicksand(
    fontSize: 49,
    fontWeight: FontWeight.w400,
    color: blackText,
  ),
  headline4: GoogleFonts.quicksand(
      fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.quicksand(
      fontSize: 19, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle1: GoogleFonts.quicksand(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.quicksand(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
