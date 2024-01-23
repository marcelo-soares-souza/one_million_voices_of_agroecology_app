import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() {
    return _MapWidget();
  }
}

class _MapWidget extends State<MapWidget> {
  bool _isLoading = true;
  late final List<Marker> _markers;

  void _loadMarkers() async {
    try {
      _markers = [];
      final res = await http.get(Uri.https(Config.omvUrl, 'locations.json'));
      for (final location in json.decode(res.body.toString())) {
        final id = location['id'];
        final latitude = location['latitude'];
        final longitude = location['longitude'];

        if (latitude != null) {
          _markers.add(Marker(
            key: Key(id.toString()),
            child: const Icon(
              Icons.location_on,
              color: Colors.green,
              size: 30.0,
            ),
            point: LatLng(latitude, longitude),
          ));
        }
      }

      if (_markers.isNotEmpty) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      throw Exception('[MapWidget] Error: $e');
    }

    return;
  }

  @override
  void initState() {
    _loadMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      content = FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(16.0, 16.0),
          initialZoom: 3.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          SuperclusterLayer.immutable(
            initialMarkers: _markers,
            indexBuilder: IndexBuilders.computeWithOriginalMarkers,
            builder: (context, position, markerCount, extraClusterData) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue),
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
    }

    return content;
  }
}
