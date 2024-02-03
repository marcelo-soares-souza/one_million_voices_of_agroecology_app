import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'dart:convert';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';
import 'package:one_million_voices_of_agroecology_app/helpers/custom_interceptor.dart';
import 'package:one_million_voices_of_agroecology_app/models/gallery_item.dart';
import 'package:one_million_voices_of_agroecology_app/models/location.dart';
import 'package:one_million_voices_of_agroecology_app/services/auth_service.dart';

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

  static Future<List<GalleryItem>> retrieveLocationGallery(String locationId) async {
    final List<GalleryItem> gallery = [];

    final res = await httpClient.get(Config.getURI('/locations/$locationId/gallery.json'));

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

  static Future<Map<String, String>> sendLocation(Location location) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final locationJson = location.toJson();

      locationJson.remove('id');
      locationJson.remove('created_at');
      locationJson.remove('updated_at');

      final body = json.encode(locationJson);

      debugPrint('[DEBUG]: sendLocation body: $body');

      final res = await httpClient.post(Config.getURI('/locations.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      var message = json.decode(res.body);
      var error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Location added'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> sendMediaToLocation(GalleryItem galleryItem) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final galleryItemJson = galleryItem.toJson();

      galleryItemJson.remove('id');
      galleryItemJson.remove('created_at');
      galleryItemJson.remove('updated_at');

      final body = json.encode(galleryItemJson);

      debugPrint('[DEBUG]: sendMediaToLocation body: $body');

      final res = await httpClient.post(Config.getURI('/locations/${galleryItem.locationId}/medias.json'), body: body);

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      var message = json.decode(res.body);

      var error = message['error'].toString().replaceAll('{', '').replaceAll('}', '');

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Location added'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> removeLocation(int locationId) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final res = await httpClient.delete(Config.getURI('/locations/$locationId.json'));

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      String error = 'Generic Error. Please try again.';
      if (res.body.isNotEmpty) {
        var message = json.decode(res.body);
        error = message['error'] ? message['error'].toString().replaceAll('{', '').replaceAll('}', '') : '';
      }

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Location removed'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }

  static Future<Map<String, String>> removeGalleryItem(int locationId, int mediaId) async {
    bool isTokenValid = await AuthService.validateToken();

    if (isTokenValid) {
      final res = await httpClient.delete(Config.getURI('/locations/$locationId/medias/$mediaId.json'));

      debugPrint('[DEBUG]: statusCode ${res.statusCode}');
      debugPrint('[DEBUG]: Body ${res.body}');

      String error = '';

      if (res.body.isNotEmpty) {
        var message = json.decode(res.body);
        error = message['error'] ? message['error'].toString().replaceAll('{', '').replaceAll('}', '') : '';
      }

      if (res.statusCode >= 400) return {'status': 'failed', 'message': error};

      return {'status': 'success', 'message': 'Media removed'};
    }
    return {'status': 'failed', 'message': 'An error occured. Please login again.'};
  }
}
