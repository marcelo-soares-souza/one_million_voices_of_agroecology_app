import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/location_helper.dart';

import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/screens/location_details.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() {
    return _MapWidget();
  }
}

class _MapWidget extends State<MapWidget> {
  bool _isLoading = true;
  bool _hasError = false;

  // ignore: prefer_final_fields
  List<Marker> _markers = [];
  List<Location> _locations = [];

  Future<void> _loadMarkers() async {
    try {
      _markers.clear();
      _locations.clear();

      _locations = await LocationService.retrieveAllLocations();

      for (final location in _locations) {
        if (location.hideMyLocation == 'false') {
          final id = location.id;

          if (location.latitude != 'null' && location.longitude != 'null') {
            final latitude = double.parse(location.latitude);
            final longitude = double.parse(location.longitude);

            _markers.add(
              LocationHelper.buildMarker(
                id.toString(),
                LatLng(latitude, longitude),
              ),
            );
          }
        }
      }

      if (_markers.isNotEmpty) {
        setState(() {
          _hasError = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('[DEBUG]: ${e.toString()}s');
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }

    return;
  }

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void selectLocation(BuildContext context, Location location) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => LocationDetailsScreen(location: location, disableControls: true)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      if (!_hasError) {
        content = FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(16.0, 16.0),
            minZoom: 1.0,
            maxZoom: 16.0,
            initialZoom: 3.0,
            interactionOptions: Config.interactionOptions,
          ),
          children: [
            TileLayer(
              urlTemplate: Config.osmURL,
            ),
            SuperclusterLayer.immutable(
              initialMarkers: _markers,
              indexBuilder: IndexBuilders.computeWithOriginalMarkers,
              onMarkerTap: (marker) {
                int id = int.parse(marker.key.toString().replaceAll(RegExp('[^0-9]'), ''));
                final Location location = _locations.where((l) => l.id == id).first;
                selectLocation(context, location);
              },
              builder: (context, position, markerCount, extraClusterData) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      markerCount.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      } else {
        content = RefreshIndicator(
          onRefresh: () => _loadMarkers(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 200),
                Center(
                    child: Text(
                  textAlign: TextAlign.center,
                  'An error has occurred, please try again.',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ))
              ],
            ),
          ),
        );
      }
    }

    return content;
  }
}
