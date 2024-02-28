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
    for (Country country in countries) {
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

  static List<DropdownMenuItem<String>> get dropDownFarmAndFarmingSystemOptions {
    Map<String, String> options = {
      "Mainly Home Consumption": "Mainly Home Consumption",
      "Mixed Home Consumption and Commercial": "Mixed Home Consumption and Commercial",
      "Mainly commercial": "Mainly commercial",
      "Other": "Other",
      "I am not sure": "I am not sure",
      "": "None of above",
    };

    List<DropdownMenuItem<String>> farmAndFarmingSystemItems = [];
    for (MapEntry<String, String> option in options.entries) {
      farmAndFarmingSystemItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return farmAndFarmingSystemItems;
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
