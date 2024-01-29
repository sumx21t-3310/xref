import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeExtension on Brightness {
  ThemeData get theme => createTheme(this);
}

ThemeData createTheme(Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorSchemeSeed: Colors.blue,
    fontFamily: GoogleFonts.murecho().fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
