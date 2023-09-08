import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bsColor = Color(0xFFe2e2ff);
  static Color mainColor = Color(0xFF000633);
  static Color accentColor = Color(0xFF0065FF);

  static List<Color> cardColor = [
    Colors.white,
    Color.fromARGB(255, 245, 190, 196),
    Colors.pink.shade100,
    Color.fromARGB(255, 239, 196, 132),
    Colors.yellow.shade100,
    Color.fromARGB(255, 158, 218, 160),
    Colors.blue.shade100,
    Color.fromARGB(255, 118, 147, 195),
    Color.fromARGB(255, 164, 129, 116),
    Color.fromARGB(255, 107, 193, 205),
    Color.fromARGB(255, 110, 154, 190),
    Color.fromARGB(255, 181, 214, 83),
  ];

  static TextStyle mainTitle =
      GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold);

  static TextStyle mainCounter =
      GoogleFonts.roboto(fontSize: 16.0, fontWeight: FontWeight.normal);

  static TextStyle dateTitle =
      GoogleFonts.roboto(fontSize: 13.0, fontWeight: FontWeight.w500);
}
