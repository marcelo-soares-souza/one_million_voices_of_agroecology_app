import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:one_million_voices_of_agroecology_app/screens/home.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 69, 92, 76),
  background: const Color.fromARGB(255, 24, 34, 27),
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

void main() {
  runApp(const OneMillionVoicesofAgroecologyApp());
}

class OneMillionVoicesofAgroecologyApp extends StatelessWidget {
  const OneMillionVoicesofAgroecologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Million Voices of Agroecology',
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
