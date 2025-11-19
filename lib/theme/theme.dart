import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme=ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade400,
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
  ),
  scaffoldBackgroundColor: Colors.grey[100],
  textTheme: GoogleFonts.poppinsTextTheme(),
);
ThemeData DarkTheme=ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  textTheme: GoogleFonts.poppinsTextTheme(),
);