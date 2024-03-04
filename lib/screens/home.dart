import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:one_million_voices_of_agroecology_app/screens/about.dart';
import 'package:one_million_voices_of_agroecology_app/screens/locations.dart';
import 'package:one_million_voices_of_agroecology_app/screens/login.dart';
import 'package:one_million_voices_of_agroecology_app/screens/map.dart';
import 'package:one_million_voices_of_agroecology_app/screens/practices.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/drawer_widget.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/locations/new_location_widget.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/practices/new_practice_widget.dart';

class HomeScreen extends StatefulWidget {
  final Widget activePage;
  final String activePageTitle;

  const HomeScreen({super.key, this.activePage = const MapScreen(), this.activePageTitle = 'Map'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget activePage = const MapScreen();
  String activePageTitle = 'Map';
  String _searchQuery = '';

  void _addLocation() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewLocation(),
      ),
    );

    setState(() {
      activePage = const LocationsScreen();
      activePageTitle = 'Locations';
    });
  }

  void _addPractice() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewPractice(),
      ),
    );

    setState(() {
      activePage = const PracticesScreen();
      activePageTitle = 'Practices';
    });
  }

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
      case 'login':
        setState(() {
          activePage = const LoginScreen();
          activePageTitle = 'Login';
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
  void initState() {
    super.initState();
    activePage = widget.activePage;
    activePageTitle = widget.activePageTitle;
  }

  Widget getTitle() {
    Widget title = Text(
      activePageTitle,
      style: Theme.of(context).textTheme.titleLarge,
    );

    if (activePageTitle == 'Locations') {
      title = TextField(
        cursorColor: Colors.white,
        onChanged: (value) => _searchQuery = value,
        decoration: InputDecoration(
            hintText: "Search Location...",
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.4),
              fontSize: 18,
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(FontAwesomeIcons.magnifyingGlass),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(activePage: LocationsScreen(filter: _searchQuery), activePageTitle: 'Locations'),
                  ),
                );
              },
            )),
        style: const TextStyle(color: Colors.white, fontSize: 15.0),
      );
    } else if (activePageTitle == 'Practices') {
      title = TextField(
        cursorColor: Colors.white,
        onChanged: (value) => _searchQuery = value,
        decoration: InputDecoration(
            hintText: "Search Practice...",
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.4),
              fontSize: 18,
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(FontAwesomeIcons.magnifyingGlass),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(activePage: PracticesScreen(filter: _searchQuery), activePageTitle: 'Practices'),
                  ),
                );
              },
            )),
        style: const TextStyle(color: Colors.white, fontSize: 15.0),
      );
    }

    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getTitle(),
        actions: [
          if (activePageTitle == 'Locations')
            IconButton(
              onPressed: _addLocation,
              icon: const Icon(FontAwesomeIcons.plus),
            ),
          if (activePageTitle == 'Practices')
            IconButton(
              onPressed: _addPractice,
              icon: const Icon(FontAwesomeIcons.plus),
            ),
        ],
      ),
      drawer: DrawerWidget(onSelectScreen: _setScreen),
      body: activePage,
    );
  }
}
