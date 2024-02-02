import 'package:flutter/material.dart';
import 'package:dart_countries/dart_countries.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class LocationHelper {
  Map<String, bool> farmAndFarmingSystemComplementValues = {
    'Crops': false,
    'Animals': false,
    'Trees': false,
    'Fish': false,
    'Other': false,
  };

  static List<DropdownMenuItem<String>> get dropDownCountries {
    List<DropdownMenuItem<String>> countryItems = [];
    for (var country in countries) {
      countryItems.add(
        DropdownMenuItem(
          value: country.isoCode.name,
          child: Text(
            country.name.toString(),
          ),
        ),
      );
    }

    return countryItems;
  }

  static Marker buildMarker(String id, LatLng point) => Marker(
        key: Key(id),
        point: point,
        child: const Icon(
          FontAwesomeIcons.seedling,
          color: Colors.green,
          size: 30.0,
        ),
        alignment: Alignment.topCenter,
      );
}
