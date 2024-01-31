import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';

import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';
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
  // bool isFavorite = false;
  int _selectedPageIndex = 0;
  late List<GalleryItem> _gallery;

  void _retrieveGallery() async {
    _gallery = await LocationService.retrieveLocationGallery(
        widget.location.id.toString());
  }

  // void _setFavorite(Location location) {
  //   setState(() {
  //     isFavorite = true;
  //   });
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.location.name),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       _setFavorite(widget.location);
          //     },
          //     icon: AnimatedSwitcher(
          //       duration: const Duration(milliseconds: 500),
          //       child: Icon(isFavorite ? Icons.star : Icons.star_border,
          //           key: ValueKey(isFavorite)),
          //       transitionBuilder: (child, animation) => RotationTransition(
          //         turns: animation,
          //         child: child,
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (_selectedPageIndex == 0) ...[
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
              ] else if (_selectedPageIndex == 1) ...[
                //
                // Gallery
                //
                if (_gallery.isEmpty) ...[
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      'No items',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  )
                ] else
                  for (final i in _gallery) ...[
                    Stack(
                      children: [
                        CachedNetworkImage(
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                              child: SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: CircularProgressIndicator(),
                          )),
                          imageUrl: i.imageUrl,
                        ),
                        if (i.description.length > 5)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 44,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    i.description,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ]
              ]
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.locationDot),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.photoFilm),
              label: 'Gallery',
            ),
          ],
        ));
  }
}
