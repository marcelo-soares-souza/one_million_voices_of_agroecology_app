import 'package:flutter/material.dart';

class PracticeHelper {
  static List<DropdownMenuItem<String>> get dropDownWhereItIsRealizedOptions {
    Map<String, String> options = {
      "On-farm": "On-farm",
      "Off-farm": "Off-farm",
      "Other": "Other",
    };

    List<DropdownMenuItem<String>> whereItIsRealizedItems = [];
    for (var option in options.entries) {
      whereItIsRealizedItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return whereItIsRealizedItems;
  }

  Map<String, bool> agroecologyPrinciplesAddressedValues = {
    'Recycling': false,
    'Input reduction': false,
    'Soil health': false,
    'Animal health': false,
    'Biodiversity': false,
    'Synergy': false,
    'Economic diversification': false,
    'Co-creation of knowledge': false,
    'Social values and diets': false,
    'Fairness': false,
    'Connectivity': false,
    'Land and natural resource governance': false,
    'Participation': false,
  };

  Map<String, bool> foodSystemComponentsAddressedValues = {
    'Soil': false,
    'Water': false,
    'Crops': false,
    'Livestock': false,
    'Fish': false,
    'Trees': false,
    'Pests': false,
    'Energy': false,
    'Household': false,
    'Workers': false,
    'Community': false,
    'Value chain': false,
    'Policy': false,
    'Whole food system': false,
    'Other': false,
    'I am not sure': false,
  };

  static List<DropdownMenuItem<String>> get dropDownEffectiveOptions {
    Map<String, String> options = {
      "Very effective": "Very effective",
      "Rather effective": "Rather effective",
      "Neither effective nor uneffective": "Neither effective nor uneffective",
      "Rather uneffective": "Rather uneffective",
      "Very uneffective": "Very uneffective",
      "I am not sure": "I am not sure",
      "Not applicable": "Not applicable",
      "": "",
    };

    List<DropdownMenuItem<String>> effectiveItems = [];
    for (var option in options.entries) {
      effectiveItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return effectiveItems;
  }
}
