import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/custom_interceptor.dart';
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

  static Future<Location> retrieveLocation(String id) async {
    final res = await httpClient.get(Config.getURI('/locations/$id.json'));
    Location location = Location.fromJson(json.decode(res.body.toString()));

    return location;
  }

  static Future<List<GalleryItem>> retrieveLocationGallery(String id) async {
    final List<GalleryItem> gallery = [];

    final res =
        await httpClient.get(Config.getURI('/locations/$id/gallery.json'));

    debugPrint('[DEBUG]: statusCode ${res.statusCode}');
    debugPrint('[DEBUG]: body ${res.body}');

    var data = json.decode(res.body.toString());

    if (res.body.length > 14) {
      for (final item in data['gallery']) {
        gallery.add(GalleryItem.fromJson(item));
      }
    }
    return gallery;
  }

  static Future<bool> sendLocation(Location location) async {
    final locationJson = location.toJson();

    locationJson.remove('id');
    locationJson.remove('created_at');
    locationJson.remove('updated_at');

    final body = json.encode(locationJson);

    debugPrint('[DEBUG]: sendLocation body: $body');

    final res = await httpClient.post(
      Config.getURI('/locations.json'),
      headers: Config.headers,
      body: body,
    );

    debugPrint('[DEBUG]: Token ${res.body}');

    return true;
  }
}
