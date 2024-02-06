import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';

class Config {
  static const bool debugMode = kReleaseMode ? false : true;

  static const String title = 'One Million Voices of Agroecology';
  static const String omvUrl = debugMode ? '10.0.2.2:3000' : 'dev.agroecologymap.org';
  static const String aboutPage = 'https://$omvUrl/about';
  static const String osmURL = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  static const InteractionOptions interactionOptions = InteractionOptions(
    enableMultiFingerGestureRace: true,
    flags: InteractiveFlag.doubleTapDragZoom |
        InteractiveFlag.doubleTapZoom |
        InteractiveFlag.drag |
        InteractiveFlag.flingAnimation |
        InteractiveFlag.pinchZoom |
        InteractiveFlag.scrollWheelZoom,
  );

  static Uri getURI(String page) {
    return debugMode ? Uri.http(omvUrl, page) : Uri.https(omvUrl, page);
  }

  static final _colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 69, 92, 76),
    background: const Color.fromARGB(255, 24, 34, 27),
  );

  static final mainTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: _colorScheme.background,
    colorScheme: _colorScheme,
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
}
