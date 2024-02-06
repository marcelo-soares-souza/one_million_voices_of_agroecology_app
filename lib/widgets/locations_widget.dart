import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/screens/location_details.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/location_item_widget.dart';

class LocationsWidget extends StatefulWidget {
  const LocationsWidget({super.key});
  @override
  State<LocationsWidget> createState() => _LocationsWidget();
}

class _LocationsWidget extends State<LocationsWidget> {
  bool _isLoading = true;
  late final List<Location> _locations;

  void selectLocation(BuildContext context, Location location) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => LocationDetailsScreen(location: location, onRemoveLocation: _removeLocation),
      ),
    );
  }

  void _loadLocations() async {
    try {
      _locations = await LocationService.retrieveAllLocations();

      if (_locations.isNotEmpty) {
        setState(() => _isLoading = false);
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

  void _removeLocation(Location location) async {
    Map<String, String> response = await LocationService.removeLocation(location.id);
    debugPrint(response.toString());
    if (response['status'] == 'success') setState(() => _locations.remove(location));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No locations'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      content = ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (ctx, index) => Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              if (_locations[index].hasPermission) ...[
                SlidableAction(
                  onPressed: (onPressed) => selectLocation(context, _locations[index]),
                  label: 'Edit',
                  icon: FontAwesomeIcons.penToSquare,
                  backgroundColor: const Color(0xFF4A90E2),
                  foregroundColor: Colors.white,
                ),
              ]
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              if (_locations[index].hasPermission) ...[
                SlidableAction(
                  onPressed: (onPressed) => _removeLocation(_locations[index]),
                  label: 'Delete',
                  icon: FontAwesomeIcons.trash,
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                )
              ]
            ],
          ),
          key: ValueKey(_locations[index].id),
          child: LocationItemWidget(
            key: ObjectKey(_locations[index].id),
            location: _locations[index],
            onSelectLocation: selectLocation,
          ),
        ),
      );
    }

    return content;
  }
}
