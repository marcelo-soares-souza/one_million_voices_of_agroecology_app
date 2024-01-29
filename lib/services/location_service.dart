import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
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

  static Future<List<GalleryItem>> retrieveLocationGallery(String id) async {
    final List<GalleryItem> gallery = [];

    final res =
        await http.get(Uri.https(Config.omvUrl, '/locations/$id/gallery.json'));

    var data = json.decode(res.body.toString());

    if (res.body.length > 14) {
      for (final item in data['gallery']) {
        gallery.add(GalleryItem.fromJson(item));
      }
    }
    return gallery;
  }
}
