import 'package:flutter/material.dart';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/screens/home.dart';

void main() {
  runApp(const OneMillionVoicesofAgroecologyApp());
}

class OneMillionVoicesofAgroecologyApp extends StatelessWidget {
  const OneMillionVoicesofAgroecologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.title,
      theme: Config.mainTheme,
      home: const HomeScreen(),
    );
  }
}
