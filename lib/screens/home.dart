import 'package:flutter/material.dart';

import 'package:one_million_voices_of_agroecology_app/screens/about.dart';
import 'package:one_million_voices_of_agroecology_app/screens/locations.dart';
import 'package:one_million_voices_of_agroecology_app/screens/map.dart';
import 'package:one_million_voices_of_agroecology_app/screens/practices.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget activePage = const MapScreen();
  var activePageTitle = 'Map';

  void _setScreen(String screen) {
    switch (screen) {
      case 'locations':
        setState(() {
          activePage = const LocationsScreen();
          activePageTitle = 'Locations';
        });
        break;
      case 'practices':
        setState(() {
          activePage = const PracticesScreen();
          activePageTitle = 'Practices';
        });
        break;
      case 'about':
        setState(() {
          activePage = const AboutScreen();
          activePageTitle = 'About';
        });
        break;
      default:
        setState(() {
          activePage = const MapScreen();
          activePageTitle = 'Map';
        });
        break;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      drawer: DrawerWidget(onSelectScreen: _setScreen),
      body: activePage,
    );
  }
}
