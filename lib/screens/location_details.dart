import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/text_block_widget.dart';

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
            CachedNetworkImage(
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
              imageUrl: widget.location.imageUrl,
            ),
            TextBlockWidget(
              label: 'Description',
              value: widget.location.description,
            ),
            TextBlockWidget(
              label: 'Country',
              value: widget.location.country,
            ),
            TextBlockWidget(
              label: 'Farm and Farming System',
              value:
                  '${widget.location.farmAndFarmingSystem} - ${widget.location.farmAndFarmingSystemComplement}',
            ),
            TextBlockWidget(
              label: 'Responsible for Information',
              value: widget.location.responsibleForInformation,
            ),
          ],
        ),
      ),
    );
  }
}
