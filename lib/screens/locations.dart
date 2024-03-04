import 'package:flutter/material.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/locations/locations_widget.dart';

class LocationsScreen extends StatelessWidget {
  final String filter;
  const LocationsScreen({super.key, this.filter = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LocationsWidget(filter: filter));
  }
}
