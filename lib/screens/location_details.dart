import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/location_helper.dart';

import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/screens/home.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/locations/edit_location_widget.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/new_media_widget.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/text_block_widget.dart';

class LocationDetailsScreen extends StatefulWidget {
  final Location location;
  final void Function(Location location) onRemoveLocation;
  static dynamic _dummyOnRemoveLocation(Location location) {}

  const LocationDetailsScreen({super.key, required this.location, this.onRemoveLocation = _dummyOnRemoveLocation});

  @override
  State<LocationDetailsScreen> createState() {
    return _LocationDetailsScreen();
  }
}

class _LocationDetailsScreen extends State<LocationDetailsScreen> {
  bool _sendMedia = false;
  bool _isLoading = true;
  int _selectedPageIndex = 0;
  late List<GalleryItem> _gallery;
  late Location _location;
  Marker? _marker;

  void _retrieveGallery() async {
    _location = await LocationService.retrieveLocation(widget.location.id.toString());
    _gallery = await LocationService.retrieveLocationGallery(widget.location.id.toString());

    _marker = LocationHelper.buildMarker(
        _location.id.toString(),
        LatLng(
          double.parse(_location.latitude),
          double.parse(_location.longitude),
        ));
    setState(() => _isLoading = false);
  }

  void _removeGalleryItem(GalleryItem galleryItem) async {
    Map<String, String> response = await LocationService.removeGalleryItem(widget.location.id, galleryItem.id);
    if (response['status'] == 'success') setState(() => _gallery.remove(galleryItem));
  }

  void _selectPage(int index) {
    setState(() {
      _isLoading = true;
      _selectedPageIndex = index;
      _sendMedia = false;

      if (_selectedPageIndex == 1) {
        _retrieveGallery();
      } else {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveGallery();
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
          contentTextStyle: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          title: const Text('Delete this Location'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                widget.onRemoveLocation(widget.location);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _editLocation(Location location) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EditLocation(location: location),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const Center(child: CircularProgressIndicator());

    if (!_isLoading) {
      activePage = SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 4),
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
                imageUrl: _location.imageUrl,
              ),
              TextBlockWidget(
                label: 'Description',
                value: _location.description,
              ),
              TextBlockWidget(
                label: 'Country',
                value: _location.country,
              ),
              TextBlockWidget(
                label: 'Farm and Farming System',
                value: '${_location.farmAndFarmingSystem} - ${_location.farmAndFarmingSystemComplement}',
              ),
              TextBlockWidget(
                label: 'Details of the farming system',
                value: _location.farmAndFarmingSystemDetails,
              ),
              TextBlockWidget(
                label: 'What is your dream ',
                value: _location.whatIsYourDream,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                'Location',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(double.parse(_location.latitude), double.parse(_location.longitude)),
                      minZoom: 1.0,
                      maxZoom: 16.0,
                      initialZoom: 2.0,
                      interactionOptions: Config.interactionOptions,
                    ),
                    children: [
                      TileLayer(urlTemplate: Config.osmURL),
                      MarkerLayer(markers: [_marker!])
                    ],
                  ),
                ),
              ),
              TextBlockWidget(
                label: 'Responsible for Information',
                value: _location.responsibleForInformation,
              ),
            ] else if (_selectedPageIndex == 1 && _sendMedia == false) ...[
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
                  Slidable(
                    key: ValueKey(i.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        if (_location.hasPermission)
                          SlidableAction(
                            onPressed: (onPressed) => _removeGalleryItem(i),
                            label: 'Delete',
                            icon: FontAwesomeIcons.trash,
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                          )
                      ],
                    ),
                    child: Stack(
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
                        if (i.description.length > 4)
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
                  ),
                  const SizedBox(height: 20),
                ],
            ] else if (_selectedPageIndex == 1 && _sendMedia == true) ...[
              NewMediaWidget(
                locationId: widget.location.id.toString(),
                onSetPage: _selectPage,
              ),
            ]
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name),
        actions: [
          if (!_isLoading && _location.hasPermission) ...[
            if (_selectedPageIndex == 1)
              IconButton(
                  icon: const Icon(FontAwesomeIcons.camera),
                  color: Colors.orange,
                  onPressed: () {
                    _selectPage(1);
                    setState(() {
                      _sendMedia = true;
                    });
                  })
            else if (_selectedPageIndex == 0 && _location.hasPermission) ...[
              IconButton(
                icon: const Icon(FontAwesomeIcons.penToSquare),
                color: Colors.green,
                onPressed: () {
                  _editLocation(_location);
                },
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.trashCan),
                color: Colors.red,
                onPressed: _showAlertDialog,
              ),
            ]
          ]
        ],
      ),
      body: activePage,
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
      ),
    );
  }
}
