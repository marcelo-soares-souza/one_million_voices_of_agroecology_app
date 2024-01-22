import 'package:flutter/material.dart';

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
                'Select...',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ]),
          ),
          ListTile(
            leading: Icon(
              Icons.map,
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
              Icons.location_pin,
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
              Icons.forest,
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
        ],
      ),
    );
  }
}
