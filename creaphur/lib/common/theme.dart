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
ThemeData appTheme(BuildContext context) => Theme.of(context).copyWith(
      textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6c47ff)),
    );
