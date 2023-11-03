import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme(BuildContext context) => ThemeData(
      textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff6c47ff),
        onPrimary: Colors.white,
        secondary: Color(0xff2bca70),
        onSecondary: Colors.white,
        error: Color(0xFFF32424),
        onError: Color(0xFFF32424),
        background: Color(0xFFF1F2F3),
        onBackground: Colors.black,
        surface: Colors.white24,
        onSurface: Color(0xff2900cc),
        primaryContainer: Color(0xffad99ff),
        secondaryContainer: Color(0xff89e6b1),
        onPrimaryContainer: Colors.white,
      ),
      useMaterial3: true,
    );
