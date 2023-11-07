import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
Colors for reference:
          Color(4285286399), - main purple
          Color(4280877260), - dark purple
          Color(4281059952), - main green
          Color(4280125259), - dark green
          Color(4289567231), - light purple
          Color(4287227569), - light green
*/
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
