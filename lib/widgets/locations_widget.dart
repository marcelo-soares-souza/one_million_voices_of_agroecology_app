import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/location_item_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/location.dart';

class LocationsWidget extends StatefulWidget {
  const LocationsWidget({super.key});
  @override
  State<LocationsWidget> createState() {
    return _LocationsWidget();
  }
}

class _LocationsWidget extends State<LocationsWidget> {
  bool _isLoading = true;
  late final List<Location> _locations;

  void _loadLocations() async {
    try {
      _locations = [];
      final res = await http.get(Uri.https(Config.omvUrl, 'locations.json'));
      for (final location in json.decode(res.body.toString())) {
        _locations.add(Location.fromJson(location));
      }

      if (_locations.isNotEmpty) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      throw Exception('[LocationsWidget] Error: $e');
    }

    return;
  }

  @override
  void initState() {
    _loadLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No locations'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      content = ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (ctx, index) => LocationItemWidget(
          key: ObjectKey(_locations[index].id),
          location: _locations[index],
        ),
      );
    }

    return content;
  }
}
