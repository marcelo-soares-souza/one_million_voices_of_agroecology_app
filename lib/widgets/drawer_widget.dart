import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';

class DrawerWidget extends StatelessWidget {
  final void Function(String screen) onSelectScreen;

  const DrawerWidget({super.key, required this.onSelectScreen});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(children: [
              Text(
                Config.title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ]),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.map,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text('Map',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24)),
            onTap: () {
              onSelectScreen('map');
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.locationDot,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text('Locations',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24)),
            onTap: () {
              onSelectScreen('locations');
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.seedling,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text('Practices',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24)),
            onTap: () {
              onSelectScreen('practices');
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.info,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text('About',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24)),
            onTap: () {
              onSelectScreen('about');
            },
          )
        ],
      ),
    );
  }
}
