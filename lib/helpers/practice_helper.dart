import 'package:flutter/material.dart';

class PracticeHelper {
  static List<DropdownMenuItem<String>> get dropDownWhereItIsRealizedOptions {
    Map<String, String> options = {
      "On-farm": "On-farm",
      "Off-farm": "Off-farm",
      "Other": "Other",
      "": "None of above",
    };

    List<DropdownMenuItem<String>> whereItIsRealizedItems = [];
    for (MapEntry<String, String> option in options.entries) {
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
      "": "None of above",
    };

    List<DropdownMenuItem<String>> effectiveItems = [];
    for (MapEntry<String, String> option in options.entries) {
      effectiveItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return effectiveItems;
  }

  static List<DropdownMenuItem<String>> get dropDownKnowledgeAndSkillsOptions {
    Map<String, String> options = {
      "High specialised knowledge required": "High specialised knowledge required",
      "Rather high specialised knowledge required": "Rather high specialised knowledge required",
      "Specialised knowledge required neither high nor low": "Specialised knowledge required neither high nor low",
      "Rather low specialised knowledge required": "Rather low specialised knowledge required",
      "No specialised knowledge required": "No specialised knowledge required",
      "I am not sure": "I am not sure",
      "Not applicable": "Not applicable",
      "": "None of above",
    };

    List<DropdownMenuItem<String>> knowledgeAndSkillsItems = [];
    for (MapEntry<String, String> option in options.entries) {
      knowledgeAndSkillsItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return knowledgeAndSkillsItems;
  }

  static List<DropdownMenuItem<String>> get dropDownLabourOptions {
    Map<String, String> options = {
      "High labour required": "High labour required",
      "Rather high labour required": "Rather high labour required",
      "Neither high nor low labout required": "Neither high nor low labout required",
      "Rather low labour required": "Rather low labour required",
      "Low labour required": "Low labour required",
      "I am not sure": "I am not sure",
      "Not applicable": "Not applicable",
      "": "None of above",
    };

    List<DropdownMenuItem<String>> labourItems = [];
    for (MapEntry<String, String> option in options.entries) {
      labourItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return labourItems;
  }

  static List<DropdownMenuItem<String>> get dropDownCostsOptions {
    Map<String, String> options = {
      "High costs": "High costs",
      "Rather high costs": "Rather high costs",
      "Neither high nor low costs": "Neither high nor low costs",
      "Rather low costs": "Rather low costs",
      "Low costs": "Low costs",
      "I am not sure": "I am not sure",
      "Not applicable": "Not applicable",
      "": "None of above",
    };

    List<DropdownMenuItem<String>> costsItems = [];
    for (MapEntry<String, String> option in options.entries) {
      costsItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return costsItems;
  }

  static List<DropdownMenuItem<String>> get dropDownDegradedOptions {
    Map<String, String> options = {
      "Works well in depleted environment": "Works well in depleted environment",
      "Works rather well in depleted environment": "Works rather well in depleted environment",
      "Neither works well nor poorly in depleted environment": "Neither works well nor poorly in depleted environment",
      "Does rather not work in depleted environment": "Does rather not work in depleted environment",
      "Does not work at all in depleted environment": "Does not work at all in depleted environment",
      "I am not sure": "I am not sure",
      "Not applicable": "Not applicable",
      "": "None of above",
    };

    List<DropdownMenuItem<String>> degradedItems = [];
    for (MapEntry<String, String> option in options.entries) {
      degradedItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return degradedItems;
  }

  static List<DropdownMenuItem<String>> get dropDownTimeOptions {
    Map<String, String> options = {
      "Works instantly": "Works instantly",
      "Works rather rapidly": "Works rather rapidly",
      "Works neither rapidly nor slowly": "Works neither rapidly nor slowly",
      "Takes rather long to work": "Takes rather long to work",
      "Takes very long to work": "Takes very long to work",
      "I am not sure": "I am not sure",
      "Not applicable": "Not applicable",
      "": "None of above",
    };

    List<DropdownMenuItem<String>> timeItems = [];
    for (MapEntry<String, String> option in options.entries) {
      timeItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return timeItems;
  }

  Map<String, bool> knowledgeSourceValues = {
    'Formal knowledge': false,
    'Indigenous knowledge': false,
    'Local knowledge': false,
    'Personal experimentation': false,
    'Other': false,
    'I am not sure': false,
  };

  static List<DropdownMenuItem<String>> get dropDownKnowledgeTimingOptions {
    Map<String, String> options = {
      "A long time ago": "A long time ago",
      "Some time ago": "Some time ago",
      "Recently": "Recently",
      "I am not sure": "I am not sure",
      "": "None of above",
    };

    List<DropdownMenuItem<String>> knowledgeTimingItems = [];
    for (MapEntry<String, String> option in options.entries) {
      knowledgeTimingItems.add(
        DropdownMenuItem(
          value: option.key,
          child: Text(option.key),
        ),
      );
    }

    return knowledgeTimingItems;
  }
}
