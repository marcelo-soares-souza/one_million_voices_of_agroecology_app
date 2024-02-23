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
}
