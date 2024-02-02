import 'package:flutter/material.dart';

class FormHelper {
  static String? validateInputSize(String? value, int min, int max) {
    if (value == null || value.isEmpty || value.trim().length <= min || value.trim().length > max) {
      return 'Must be between $min and $max characters long.';
    }
    return null;
  }

  static List<DropdownMenuItem<String>> get dropDownYesNo {
    List<DropdownMenuItem<String>> yesNoItems = [];
    yesNoItems.add(const DropdownMenuItem(value: 'true', child: Text('Yes')));
    yesNoItems.add(const DropdownMenuItem(value: 'false', child: Text('No')));
    return yesNoItems;
  }
}
