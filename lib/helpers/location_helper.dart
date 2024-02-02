import 'package:flutter/material.dart';
import 'package:dart_countries/dart_countries.dart';

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
}
