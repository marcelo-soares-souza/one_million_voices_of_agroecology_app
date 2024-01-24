import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';

class LocationDetailsScreen extends StatefulWidget {
  final Location location;

  const LocationDetailsScreen({super.key, required this.location});

  @override
  State<LocationDetailsScreen> createState() {
    return _LocationDetailsScreen();
  }
}

class _LocationDetailsScreen extends State<LocationDetailsScreen> {
  bool isFavorite = false;

  void _setFavorite(Location location) {
    setState(() {
      isFavorite = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name),
        actions: [
          IconButton(
            onPressed: () {
              _setFavorite(widget.location);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Icon(isFavorite ? Icons.star : Icons.star_border,
                  key: ValueKey(isFavorite)),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: animation,
                child: child,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.location.id,
              child: Image.network(
                widget.location.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            Text(
              widget.location.description,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 14),
            Text(
              'Country',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            Text(
              widget.location.country,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 14),
            Text(
              'Farm and Farming System',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            Text(
              widget.location.farmAndFarmingSystem,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 14),
            Text(
              'Responsible for Information',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            Text(
              widget.location.responsibleForInformation,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
