import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';

class LocationService {
  static Future<List<Location>> retrieveAllLocations() async {
    final List<Location> locations = [];

    final res = await http.get(Uri.https(Config.omvUrl, 'locations.json'));

    for (final location in json.decode(res.body.toString())) {
      locations.add(Location.fromJson(location));
    }

    return locations;
  }
}
