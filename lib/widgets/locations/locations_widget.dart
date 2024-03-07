import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/form_helper.dart';

import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/screens/location_details.dart';
import 'package:one_million_voices_of_agroecology_app/services/location_service.dart';
import 'package:one_million_voices_of_agroecology_app/widgets/locations/location_item_widget.dart';

class LocationsWidget extends StatefulWidget {
  final String filter;

  const LocationsWidget({super.key, this.filter = ''});

  @override
  State<LocationsWidget> createState() => _LocationsWidget();
}

class _LocationsWidget extends State<LocationsWidget> {
  bool _isLoading = true;
  List<Location> _locations = [];

  void selectLocation(BuildContext context, Location location) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => LocationDetailsScreen(location: location, onRemoveLocation: _removeLocation),
      ),
    );
  }

  Future<void> _loadLocations() async {
    try {
      _locations.clear();

      if (widget.filter.isNotEmpty) {
        _locations = await LocationService.retrieveLocationsByFilter(widget.filter);
      } else {
        _locations = await LocationService.retrieveAllLocations();
      }

      setState(() => _isLoading = false);
    } catch (e) {
      throw Exception('[LocationsWidget] Error: $e');
    }

    return;
  }

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  void _removeLocation(Location location) async {
    Map<String, String> response = await LocationService.removeLocation(location.id);
    if (response['status'] == 'success') setState(() => _locations.remove(location));

    if (!mounted) return;
    FormHelper.successMessage(context, 'Location removed');
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(children: [
      const SizedBox(height: 200),
      Center(
          child: Text(
        textAlign: TextAlign.center,
        'No locations found',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ))
    ]);

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      if (_locations.isNotEmpty) {
        content = RefreshIndicator(
          onRefresh: () async {
            setState(() => _isLoading = true);
            await _loadLocations();
          },
          child: ListView.builder(
            itemCount: _locations.length,
            itemBuilder: (ctx, index) => Slidable(
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
          ),
        );
      }
    }

    return content;
  }
}
