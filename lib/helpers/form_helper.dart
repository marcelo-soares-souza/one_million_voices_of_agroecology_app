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
    yesNoItems.add(const DropdownMenuItem(value: 'Yes', child: Text('Yes')));
    yesNoItems.add(const DropdownMenuItem(value: 'No', child: Text('No')));
    yesNoItems.add(const DropdownMenuItem(value: '', child: Text('None of above')));

    return yesNoItems;
  }

  static List<DropdownMenuItem<String>> get dropDownYesNoBool {
    List<DropdownMenuItem<String>> yesNoBoolItems = [];
    yesNoBoolItems.add(const DropdownMenuItem(value: 'true', child: Text('Yes')));
    yesNoBoolItems.add(const DropdownMenuItem(value: 'false', child: Text('No')));
    yesNoBoolItems.add(const DropdownMenuItem(value: '', child: Text('None of above')));

    return yesNoBoolItems;
  }

  static successMessage(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }

  static infoMessage(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue,
    ));
  }

  static errorMessage(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
