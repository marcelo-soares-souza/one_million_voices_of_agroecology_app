import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/configs/custom_interceptor.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';

class LocationService {
  static InterceptedClient httpClient = InterceptedClient.build(
    interceptors: [
      CustomInterceptor(),
    ],
  );

  static Future<List<Location>> retrieveAllLocations() async {
    final List<Location> locations = [];

    final res = await httpClient.get(Config.getURI('locations.json'));

    for (final location in json.decode(res.body.toString())) {
      locations.add(Location.fromJson(location));
    }

    return locations;
  }

  static Future<List<GalleryItem>> retrieveLocationGallery(String id) async {
    final List<GalleryItem> gallery = [];

    final res =
        await httpClient.get(Config.getURI('/locations/$id/gallery.json'));

    var data = json.decode(res.body.toString());

    if (res.body.length > 14) {
      for (final item in data['gallery']) {
        gallery.add(GalleryItem.fromJson(item));
      }
    }
    return gallery;
  }

  static Future<bool> sendLocation(Location location) async {
    final res = await httpClient.post(
      Config.getURI('/locations.json'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json
          .encode({'name': location.name, 'description': location.description}),
    );

    debugPrint('[DEBUG]: Token ${res.body}');

    return true;
  }
}
